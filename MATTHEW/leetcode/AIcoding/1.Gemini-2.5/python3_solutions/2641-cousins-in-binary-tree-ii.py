import collections

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def replaceValueInTree(self, root: TreeNode) -> TreeNode:
        if not root:
            return None

        level_sum_map = collections.defaultdict(int)
        parent_child_sum_map = collections.defaultdict(int)
        node_depth_map = {}
        node_parent_map = {}

        # Pass 1: BFS to collect necessary information
        # Queue stores tuples of (node, parent_node, depth)
        queue = collections.deque([(root, None, 0)])
        node_depth_map[root] = 0
        node_parent_map[root] = None

        all_nodes = [] # To store all nodes for easy iteration in Pass 2

        while queue:
            node, parent, depth = queue.popleft()
            all_nodes.append(node) 

            level_sum_map[depth] += node.val

            if parent:
                parent_child_sum_map[parent] += node.val

            if node.left:
                node_depth_map[node.left] = depth + 1
                node_parent_map[node.left] = node
                queue.append((node.left, node, depth + 1))
            if node.right:
                node_depth_map[node.right] = depth + 1
                node_parent_map[node.right] = node
                queue.append((node.right, node, depth + 1))

        # Pass 2: Update node values based on collected information
        for node in all_nodes:
            depth = node_depth_map[node]

            if depth == 0: # Root node has no cousins
                node.val = 0
            else:
                parent = node_parent_map[node]
                total_sum_at_this_level = level_sum_map[depth]
                sum_of_siblings_and_self = parent_child_sum_map[parent]

                # Cousins sum = (total sum of all nodes at this level) - (sum of current node and its siblings)
                node.val = total_sum_at_this_level - sum_of_siblings_and_self

        return root