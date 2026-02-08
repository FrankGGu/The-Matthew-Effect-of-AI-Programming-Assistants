class Solution:
    def subarrayXor(self, nums: List[int], k: int) -> int:
        n = len(nums)
        count = 0
        for i in range(n):
            xor_sum = 0
            for j in range(i, n):
                xor_sum ^= nums[j]
                if xor_sum == k:
                    count += 1
        return count