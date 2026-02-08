class TrieNode:
    def __init__(self):
        self.children = [None, None]
        self.count = 0

class Trie:
    def __init__(self, bit_length):
        self.root = TrieNode()
        self.bit_length = bit_length

    def insert(self, num):
        node = self.root
        for i in range(self.bit_length - 1, -1, -1):
            bit = (num >> i) & 1
            if not node.children[bit]:
                node.children[bit] = TrieNode()
            node = node.children[bit]
            node.count += 1

    def query_less_than_target(self, num, target):
        """
        Counts numbers 'y' in the Trie such that (num XOR y) < target.
        """
        node = self.root
        count = 0
        for i in range(self.bit_length - 1, -1, -1):
            if not node:
                break

            num_bit = (num >> i) & 1
            target_bit = (target >> i) & 1

            if target_bit == 1:
                # If target_bit is 1, and we choose y_bit such that (num_bit XOR y_bit) == 0,
                # then (num XOR y) will have a 0 at this bit position, making it strictly less than target.
                # So, add all numbers from the branch where y_bit is num_bit.
                if node.children[num_bit]:
                    count += node.children[num_bit].count

                # To potentially make (num XOR y) equal to target up to this point,
                # we must choose y_bit such that (num_bit XOR y_bit) == 1.
                # This means y_bit must be (1 - num_bit).
                node = node.children[1 - num_bit]
            else: # target_bit == 0
                # If target_bit is 0, and we choose y_bit such that (num_bit XOR y_bit) == 1,
                # then (num XOR y) will have a 1 at this bit position, making it strictly greater than target.
                # This path is not allowed.
                # We must choose y_bit such that (num_bit XOR y_bit) == 0.
                # This means y_bit must be num_bit.
                node = node.children[num_bit]

        return count

class Solution:
    def countPairs(self, nums: list[int], low: int, high: int) -> int:
        # Max value for nums[i], low, high is 2 * 10^9.
        # 2^30 = 1,073,741,824
        # 2^31 = 2,147,483,648
        # Numbers can go up to bit 30. We need 31 bits (from 0 to 30).
        BIT_LENGTH = 31

        trie = Trie(BIT_LENGTH)
        total_pairs = 0

        for num in nums:
            # For current num, count how many existing numbers 'y' (already in trie)
            # satisfy low <= (num XOR y) <= high.
            # This is equivalent to:
            # (count y such that (num XOR y) < high + 1) - (count y such that (num XOR y) < low)

            count_le_high = trie.query_less_than_target(num, high + 1)
            count_lt_low = trie.query_less_than_target(num, low)

            total_pairs += (count_le_high - count_lt_low)

            trie.insert(num)

        return total_pairs