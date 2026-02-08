class Solution:
    def sumOfPower(self, nums: List[int], k: int) -> int:
        n = len(nums)
        count = 0

        for i in range(n):
            current_sum = 0
            for j in range(i, n):
                current_sum += nums[j]
                if current_sum == k:
                    count += 1

        return count