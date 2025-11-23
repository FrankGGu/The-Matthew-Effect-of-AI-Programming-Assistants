class Solution:
    def findErrorNums(self, nums: list[int]) -> list[int]:
        n = len(nums)
        seen = [False] * (n + 1)
        repeated = -1
        missing = -1

        for num in nums:
            if seen[num]:
                repeated = num
            seen[num] = True

        for i in range(1, n + 1):
            if not seen[i]:
                missing = i
                break

        return [repeated, missing]