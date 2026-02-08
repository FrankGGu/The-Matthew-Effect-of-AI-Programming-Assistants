class TrieNode:
    def __init__(self):
        self.children = {} # Stores children nodes for bits 0 and 1

class Trie:
    def __init__(self):
        self.root = TrieNode()
        # Maximum possible bit position for numbers up to 2^31 - 1 is 30 (0-indexed)
        self.L = 30 

    def insert(self, num):
        curr = self.root
        # Iterate from the most significant bit down to the least significant bit
        for i in range(self.L, -1, -1):
            bit = (num >> i) & 1 # Get the i-th bit of num
            if bit not in curr.children:
                curr.children[bit] = TrieNode()
            curr = curr.children[bit]

    def find_max_xor(self, num):
        curr = self.root
        current_xor_sum = 0
        # Iterate from the most significant bit down to the least significant bit
        for i in range(self.L, -1, -1):
            bit = (num >> i) & 1 # Get the i-th bit of num
            opposite_bit = 1 - bit

            # Try to find the opposite bit in the Trie to maximize XOR
            if opposite_bit in curr.children:
                # If opposite bit exists, taking it results in a 1 at this bit position for the XOR sum
                current_xor_sum |= (1 << i) 
                curr = curr.children[opposite_bit]
            else:
                # If opposite bit does not exist, we must take the same bit
                # Taking the same bit results in a 0 at this bit position for the XOR sum, so current_xor_sum is unchanged
                curr = curr.children[bit]
        return current_xor_sum

class Solution:
    def findMaximumXOR(self, nums: list[int]) -> int:
        trie = Trie()

        # Insert all numbers into the Trie
        for num in nums:
            trie.insert(num)

        max_xor = 0
        # For each number in the input array, find the maximum XOR it can form
        # with any number already present in the Trie.
        for num in nums:
            max_xor = max(max_xor, trie.find_max_xor(num))

        return max_xor