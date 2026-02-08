class TrieNode:
    def __init__(self):
        self.children = {} # '0': TrieNode, '1': TrieNode

class Trie:
    def __init__(self):
        self.root = TrieNode()
        self.L = 30 # Max bit index for numbers up to 2^31 - 1 (i.e., 31 bits from index 0 to 30)

    def insert(self, num: int):
        node = self.root
        for i in range(self.L, -1, -1): # Iterate from MSB to LSB
            bit = (num >> i) & 1
            if bit not in node.children:
                node.children[bit] = TrieNode()
            node = node.children[bit]

    def find_max_xor_pair(self, num: int) -> int:
        node = self.root
        current_xor_sum = 0
        for i in range(self.L, -1, -1):
            bit = (num >> i) & 1
            opposite_bit = 1 - bit

            if opposite_bit in node.children:
                # If the opposite bit exists, taking it maximizes the XOR sum at this position
                current_xor_sum |= (1 << i) # Set the i-th bit of the XOR sum to 1
                node = node.children[opposite_bit]
            else:
                # Otherwise, we must take the same bit path
                node = node.children[bit]
        return current_xor_sum

class Solution:
    def findMaximumXOR(self, nums: list[int]) -> int:
        trie = Trie()

        # Build the Trie by inserting all numbers
        for num in nums:
            trie.insert(num)

        max_xor = 0
        # For each number, query the Trie to find the maximum XOR value with any other number
        for num in nums:
            max_xor = max(max_xor, trie.find_max_xor_pair(num))

        return max_xor