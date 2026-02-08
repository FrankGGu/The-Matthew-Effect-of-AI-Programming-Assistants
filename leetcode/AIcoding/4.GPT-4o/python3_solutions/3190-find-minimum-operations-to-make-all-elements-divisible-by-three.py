class Solution:
    def minOperations(self, nums: List[int]) -> int:
        count = [0, 0, 0]
        for num in nums:
            count[num % 3] += 1

        # The minimum operations needed to make all elements divisible by 3
        return min(count[1], count[2]) + (abs(count[1] - count[2]) // 3)