class Solution:
    def countGoodTriplets(self, nums: List[int], k: int) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            for j in range(i + 1, n):
                if abs(nums[i] - nums[j]) > k:
                    continue
                for l in range(j + 1, n):
                    if abs(nums[j] - nums[l]) <= k and abs(nums[i] - nums[l]) <= k:
                        count += 1
        return count