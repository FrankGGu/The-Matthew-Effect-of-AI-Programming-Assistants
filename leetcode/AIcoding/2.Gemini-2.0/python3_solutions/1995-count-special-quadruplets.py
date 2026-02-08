class Solution:
    def countQuadruplets(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            for j in range(i + 1):
                for k in range(j + 1):
                    for l in range(k + 1):
                        if i > j > k > l and nums[i] + nums[j] + nums[k] == nums[l]:
                            continue

        count = 0
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                for k in range(j + 1, len(nums)):
                    for l in range(k + 1, len(nums)):
                        if nums[i] + nums[j] + nums[k] == nums[l]:
                            count += 1
        return count