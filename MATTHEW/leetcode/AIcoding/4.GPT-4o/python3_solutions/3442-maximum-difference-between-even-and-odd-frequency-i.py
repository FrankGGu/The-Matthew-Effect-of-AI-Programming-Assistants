class Solution:
    def maximumDifference(self, nums: List[int]) -> int:
        freq = [0] * 100001
        for num in nums:
            freq[num] += 1

        max_even = -1
        max_odd = -1

        for i in range(len(freq)):
            if freq[i] % 2 == 0 and freq[i] > max_even:
                max_even = freq[i]
            elif freq[i] % 2 == 1 and freq[i] > max_odd:
                max_odd = freq[i]

        if max_even == -1 or max_odd == -1:
            return -1
        return max_even - max_odd