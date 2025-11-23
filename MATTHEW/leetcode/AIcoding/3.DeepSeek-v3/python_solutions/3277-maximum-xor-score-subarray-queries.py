class Solution:
    def maxXorSubarray(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        class TrieNode:
            __slots__ = ['children']
            def __init__(self):
                self.children = [None, None]

        class Trie:
            def __init__(self):
                self.root = TrieNode()

            def insert(self, num):
                node = self.root
                for i in range(31, -1, -1):
                    bit = (num >> i) & 1
                    if not node.children[bit]:
                        node.children[bit] = TrieNode()
                    node = node.children[bit]

            def find_max_xor(self, num):
                node = self.root
                max_xor = 0
                for i in range(31, -1, -1):
                    bit = (num >> i) & 1
                    toggle_bit = 1 - bit
                    if node.children[toggle_bit]:
                        max_xor += (1 << i)
                        node = node.children[toggle_bit]
                    else:
                        node = node.children[bit]
                return max_xor

        prefix = [0] * (len(nums) + 1)
        for i in range(len(nums)):
            prefix[i+1] = prefix[i] ^ nums[i]

        queries_with_indices = [(left, right, idx) for idx, (left, right) in enumerate(queries)]
        queries_with_indices.sort(key=lambda x: x[1])

        trie = Trie()
        res = [0] * len(queries)
        ptr = 0

        for left, right, idx in queries_with_indices:
            while ptr <= right:
                trie.insert(prefix[ptr])
                ptr += 1
            current_max = trie.find_max_xor(prefix[right + 1])
            res[idx] = current_max

        return res