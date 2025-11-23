class Solution:
    def sumOfFlooredPairs(self, nums: List[int]) -> int:
        max_num = max(nums)
        count = [0] * (max_num + 1)

        for num in nums:
            count[num] += 1

        for i in range(1, max_num + 1):
            count[i] += count[i - 1]

        result = 0
        for i in range(1, max_num + 1):
            result += count[i] * i

        return result