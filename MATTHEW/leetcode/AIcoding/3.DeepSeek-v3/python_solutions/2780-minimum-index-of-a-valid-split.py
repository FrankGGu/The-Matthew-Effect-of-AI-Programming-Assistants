class Solution:
    def minimumIndex(self, nums: List[int]) -> int:
        from collections import defaultdict

        freq = defaultdict(int)
        dominant = -1
        total_count = 0

        for num in nums:
            freq[num] += 1
            if freq[num] > total_count:
                total_count = freq[num]
                dominant = num

        left_count = 0
        for i in range(len(nums)):
            if nums[i] == dominant:
                left_count += 1
            right_count = total_count - left_count
            if left_count * 2 > (i + 1) and right_count * 2 > (len(nums) - i - 1):
                return i

        return -1