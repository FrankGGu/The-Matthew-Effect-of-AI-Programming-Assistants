class Solution:
    def findPairs(self, nums: List[int], k: int) -> int:
        count = 0
        num_freq = {}

        for num in nums:
            num_freq[num] = num_freq.get(num, 0) + 1

        for num in num_freq:
            if k > 0 and num + k in num_freq:
                count += 1
            elif k == 0 and num_freq[num] > 1:
                count += 1
        return count