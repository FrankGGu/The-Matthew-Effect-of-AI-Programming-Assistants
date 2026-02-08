class TrieNode:
    def __init__(self):
        self.children = [None, None]

class Trie:
    def __init__(self):
        self.root = TrieNode()
        self.max_bit_pos = 29

    def insert(self, num):
        node = self.root
        for i in range(self.max_bit_pos, -1, -1):
            bit = (num >> i) & 1
            if not node.children[bit]:
                node.children[bit] = TrieNode()
            node = node.children[bit]

    def find_max_xor(self, num):
        node = self.root
        max_xor_val = 0
        for i in range(self.max_bit_pos, -1, -1):
            bit = (num >> i) & 1
            if node.children[1 - bit]:
                max_xor_val |= (1 << i)
                node = node.children[1 - bit]
            else:
                node = node.children[bit]
        return max_xor_val

class Solution:
    def maximizeXor(self, nums: list[int], queries: list[list[int]]) -> list[int]:
        nums.sort()

        processed_queries = []
        for i, query in enumerate(queries):
            xi, mi = query
            processed_queries.append((mi, xi, i))

        processed_queries.sort()

        results = [-1] * len(queries)
        trie = Trie()
        num_idx = 0

        for mi, xi, original_index in processed_queries:
            while num_idx < len(nums) and nums[num_idx] <= mi:
                trie.insert(nums[num_idx])
                num_idx += 1

            if num_idx > 0:
                results[original_index] = trie.find_max_xor(xi)

        return results