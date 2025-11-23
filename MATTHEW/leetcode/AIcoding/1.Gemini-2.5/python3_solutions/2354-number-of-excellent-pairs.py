import collections

class Solution:
    def numberOfExcellentPairs(self, nums: list[int], k: int) -> int:

        # Store the frequency of set bits for each unique number in nums.
        # For example, if nums = [1, 2, 3], then unique numbers are {1, 2, 3}.
        # bits(1) = 1, bits(2) = 1, bits(3) = 2.
        # bit_counts_freq will be {1: 2, 2: 1} (meaning there are two unique numbers with 1 set bit, and one unique number with 2 set bits).

        bit_counts_freq = collections.defaultdict(int)

        # Iterate through unique numbers to count their set bits.
        for num in set(nums):
            # Python's bin() function returns a string like '0b101'.
            # count('1') gives the number of set bits.
            bits = bin(num).count('1')
            bit_counts_freq[bits] += 1

        total_excellent_pairs = 0

        # Iterate through all possible bit counts for the two numbers in a pair.
        # The maximum value for nums[i] is 10^9.
        # bin(10^9) is '0b111011100110101100101000000000', which has 13 set bits.
        # So, individual bit counts (b1, b2) will range from 0 to 13.
        # The loops can run from 0 up to (but not including) 14.

        for b1 in range(14): 
            for b2 in range(14):
                # If the sum of set bits is greater than or equal to k, it's an excellent pair.
                if b1 + b2 >= k:
                    # Multiply the frequencies to get the number of pairs.
                    # If there are freq[b1] numbers with b1 set bits and freq[b2] numbers with b2 set bits,
                    # then there are freq[b1] * freq[b2] such pairs.
                    total_excellent_pairs += bit_counts_freq[b1] * bit_counts_freq[b2]

        return total_excellent_pairs