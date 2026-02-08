class Solution:
    def countPowerOfK(self, nums: List[int], k: int) -> int:
        n = len(nums)
        count = 0

        for size in range(1, n + 1):
            for i in range(n - size + 1):
                if sum(nums[i:i + size]) % k == 0:
                    count += 1

        return count