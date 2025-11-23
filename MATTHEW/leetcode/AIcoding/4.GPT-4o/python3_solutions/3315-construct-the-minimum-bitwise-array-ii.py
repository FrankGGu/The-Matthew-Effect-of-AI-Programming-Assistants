class Solution:
    def minimumBitwiseArray(self, nums: List[int]) -> List[int]:
        n = len(nums)
        result = [0] * n
        for i in range(32):
            count = sum((num >> i) & 1 for num in nums)
            if count > 0:
                for j in range(n):
                    if (nums[j] >> i) & 1:
                        result[j] |= (1 << i)
        return result