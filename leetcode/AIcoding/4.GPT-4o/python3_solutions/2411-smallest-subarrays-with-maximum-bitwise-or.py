class Solution:
    def smallestSubarrays(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [0] * n
        max_or = [0] * n

        for i in range(n):
            max_or[i] = max_or[i - 1] if i > 0 else 0
            max_or[i] |= nums[i]

        for i in range(n):
            temp_or = 0
            for j in range(i, n):
                temp_or |= nums[j]
                if temp_or == max_or[i]:
                    res[i] = j - i + 1
                    break

        return res