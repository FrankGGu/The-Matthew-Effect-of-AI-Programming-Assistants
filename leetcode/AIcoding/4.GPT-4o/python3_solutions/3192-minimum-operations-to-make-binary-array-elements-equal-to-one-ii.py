class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        n = len(nums)
        count = sum(num == 1 for num in nums)
        if count == n:
            return 0

        left = 0
        right = 0
        total_operations = float('inf')

        while right < n:
            if nums[right] == 0:
                left += 1
            right += 1

            while left > count:
                if nums[left - 1] == 0:
                    left -= 1
                right -= 1

            total_operations = min(total_operations, left)

        return total_operations