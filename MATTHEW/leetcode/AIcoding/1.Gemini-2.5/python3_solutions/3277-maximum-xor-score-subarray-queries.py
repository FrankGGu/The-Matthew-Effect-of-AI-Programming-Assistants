class TrieNode:
    def __init__(self):
        self.children = [-1, -1]  # Store indices to trie_nodes list
        self.count = 0

trie_nodes = []  # Global list of TrieNode objects
roots = []  # List of root indices for each version of the Trie

MAX_BITS = 30  # For numbers up to 10^9, 2^30 is sufficient

def init_trie():
    global trie_nodes, roots
    trie_nodes = []
    roots = []
    # Create the initial empty Trie node (index 0)
    trie_nodes.append(TrieNode())
    roots.append(0)  # roots[0] is the index of the empty Trie

def new_node():
    trie_nodes.append(TrieNode())
    return len(trie_nodes) - 1

def insert(prev_root_idx, val):
    curr_root_idx = new_node()

    prev_root = trie_nodes[prev_root_idx]
    curr_root = trie_nodes[curr_root_idx]

    curr_root.children = list(prev_root.children)
    curr_root.count = prev_root.count + 1

    curr_prev_node_idx = prev_root_idx
    curr_new_node_idx = curr_root_idx

    for i in range(MAX_BITS - 1, -1, -1):
        bit = (val >> i) & 1

        curr_prev_node = trie_nodes[curr_prev_node_idx]
        curr_new_node = trie_nodes[curr_new_node_idx]

        # Copy the other child reference directly from the previous version
        curr_new_node.children[1-bit] = curr_prev_node.children[1-bit]

        # Create a new node for the 'bit' path
        new_child_idx = new_node()
        new_child_node = trie_nodes[new_child_idx]

        if curr_prev_node.children[bit] != -1:
            prev_child_node = trie_nodes[curr_prev_node.children[bit]]
            new_child_node.children = list(prev_child_node.children)
            new_child_node.count = prev_child_node.count + 1
        else:
            new_child_node.count = 1

        curr_new_node.children[bit] = new_child_idx

        # Move to the next level
        # If the previous path didn't exist, conceptually follow an empty path (index 0)
        curr_prev_node_idx = curr_prev_node.children[bit] if curr_prev_node.children[bit] != -1 else 0
        curr_new_node_idx = new_child_idx

    return curr_root_idx

def query_max_xor(root_j_idx, root_L_minus_1_idx, target_val):
    max_xor_val = 0
    node_j_idx = root_j_idx
    node_L_minus_1_idx = root_L_minus_1_idx

    for i in range(MAX_BITS - 1, -1, -1):
        node_j = trie_nodes[node_j_idx]
        node_L_minus_1 = trie_nodes[node_L_minus_1_idx]

        bit = (target_val >> i) & 1
        desired_bit = 1 - bit

        # Calculate count of elements in range [L, j] that follow desired_bit path
        count_desired_in_j = trie_nodes[node_j.children[desired_bit]].count if node_j.children[desired_bit] != -1 else 0
        count_desired_in_L_minus_1 = trie_nodes[node_L_minus_1.children[desired_bit]].count if node_L_minus_1.children[desired_bit] != -1 else 0

        if count_desired_in_j - count_desired_in_L_minus_1 > 0:
            # Desired path exists, take it to maximize XOR
            max_xor_val |= (1 << i)
            node_j_idx = node_j.children[desired_bit]
            node_L_minus_1_idx = node_L_minus_1.children[desired_bit]
        else:
            # Desired path doesn't exist in the range, must take the 'bit' path
            node_j_idx = node_j.children[bit]
            node_L_minus_1_idx = node_L_minus_1.children[bit]
            # If node_j_idx becomes -1, it means no numbers exist in the range, but problem constraints usually guarantee at least one.
            # The count check at the beginning of the loop ensures we only proceed if there are elements.
    return max_xor_val

class Solution:
    def maxXorScore(self, nums: list[int], queries: list[list[int]]) -> list[int]:
        global trie_nodes, roots
        init_trie()

        N = len(nums)
        prefix_xor = [0] * (N + 1)
        for i in range(N):
            prefix_xor[i+1] = prefix_xor[i] ^ nums[i]

        # roots[k] stores the root index of the Trie containing prefix_xor[0]...prefix_xor[k-1]
        # roots[0] is the empty Trie (index 0)
        # roots[1] contains prefix_xor[0]
        # roots[k+1] contains prefix_xor[0]...prefix_xor[k]
        for k in range(N + 1):
            roots.append(insert(roots[-1], prefix_xor[k]))

        results = []
        for L, R, X in queries:
            max_overall_xor = 0
            # Iterate j from L to R (inclusive)
            for j in range(L, R + 1):
                # We need to find max((nums[i] ^ ... ^ nums[j]) ^ X) for L <= i <= j
                # (nums[i] ^ ... ^ nums[j]) is equivalent to (prefix_xor[j+1] ^ prefix_xor[i])
                # So we need to maximize ((prefix_xor[j+1] ^ prefix_xor[i]) ^ X)
                # This can be rewritten as ((prefix_xor[j+1] ^ X) ^ prefix_xor[i])

                # For a fixed j, let target_val = prefix_xor[j+1] ^ X
                target_val = prefix_xor[j+1] ^ X

                # We need to find max(target_val ^ prefix_xor[i]) for i in range [L, j]
                # The Trie rooted at roots[j+1] contains prefix_xor[0]...prefix_xor[j]
                # The Trie rooted at roots[L] contains prefix_xor[0]...prefix_xor[L-1]
                # Querying with roots[j+1] and roots[L] effectively queries for elements prefix_xor[i] where L <= i <= j.
                current_max_xor = query_max_xor(roots[j+1], roots[L], target_val)
                max_overall_xor = max(max_overall_xor, current_max_xor)
            results.append(max_overall_xor)

        return results