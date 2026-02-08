class TrieNode:
    def __init__(self):
        self.children = {}
        self.count = 0

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
            node.count += 1

    def erase(self, num):
        node = self.root
        for i in range(31, -1, -1):
            bit = (num >> i) & 1
            node = node.children[bit]
            node.count -= 1

    def max_xor(self, num):
        node = self.root
        max_xor = 0
        for i in range(31, -1, -1):
            bit = (num >> i) & 1
            desired_bit = 1 - bit
            if desired_bit in node.children and node.children[desired_bit].count > 0:
                max_xor |= (1 << i)
                node = node.children[desired_bit]
            else:
                node = node.children[bit]
        return max_xor

class Solution:
    def maximumXor(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        n = len(nums)
        prefix_xor = [0] * (n + 1)
        for i in range(n):
            prefix_xor[i + 1] = prefix_xor[i] ^ nums[i]

        trie = Trie()
        results = []
        for i in range(n + 1):
            trie.insert(prefix_xor[i])

        for x, m in queries:
            if m < 0:
                results.append(-1)
            else:
                max_xor = -1
                for i in range(n + 1):
                    if prefix_xor[i] <= m:
                        max_xor = max(max_xor, trie.max_xor(prefix_xor[i] ^ x))
                results.append(max_xor)

        return results