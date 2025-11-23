class TrieNode:
    def __init__(self):
        self.children = {}
        self.value = 0

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, num):
        node = self.root
        for i in range(31, -1, -1):
            bit = (num >> i) & 1
            if bit not in node.children:
                node.children[bit] = TrieNode()
            node = node.children[bit]
        node.value = num

    def max_xor(self, num):
        node = self.root
        max_xor = 0
        for i in range(31, -1, -1):
            bit = (num >> i) & 1
            toggle_bit = 1 - bit
            if toggle_bit in node.children:
                max_xor |= (1 << i)
                node = node.children[toggle_bit]
            else:
                node = node.children[bit]
        return max_xor

class Solution:
    def maximizeXor(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        nums.sort()
        queries_with_index = sorted([(x[0], x[1], i) for i, x in enumerate(queries)])
        trie = Trie()
        result = [0] * len(queries)
        j = 0

        for mx, original_index in queries_with_index:
            while j < len(nums) and nums[j] <= mx:
                trie.insert(nums[j])
                j += 1
            result[original_index] = trie.max_xor(mx) if j > 0 else -1

        return result