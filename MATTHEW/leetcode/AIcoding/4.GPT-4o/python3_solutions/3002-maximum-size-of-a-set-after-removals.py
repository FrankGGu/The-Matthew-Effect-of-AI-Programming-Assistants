class Solution:
    def maximumSize(self, nums: List[int], maxSum: int) -> int:
        nums.sort()
        current_sum = 0
        size = 0

        for num in nums:
            if current_sum + num <= maxSum:
                current_sum += num
                size += 1
            else:
                break

        return size