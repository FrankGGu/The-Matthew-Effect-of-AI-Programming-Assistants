class Solution:
    def sumOfSquares(self, nums: List[int]) -> int:
        n = len(nums)
        result = 0

        for i in range(n):
            seen = set()
            current_sum = 0
            for j in range(i, n):
                if nums[j] in seen:
                    break
                seen.add(nums[j])
                current_sum += nums[j]
                result += current_sum ** 2

        return result