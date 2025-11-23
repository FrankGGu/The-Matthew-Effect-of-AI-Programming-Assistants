class Solution:
    def countBadPairs(self, nums: List[int]) -> int:
        n = len(nums)
        count = 0
        good_pairs = 0
        freq = {}
        for i in range(n):
            if nums[i] - i in freq:
                good_pairs += freq[nums[i] - i]
            if nums[i] - i in freq:
                freq[nums[i] - i] += 1
            else:
                freq[nums[i] - i] = 1

        return n * (n - 1) // 2 - good_pairs