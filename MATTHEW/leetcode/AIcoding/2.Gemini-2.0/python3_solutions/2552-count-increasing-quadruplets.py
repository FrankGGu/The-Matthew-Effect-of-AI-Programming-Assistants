class Solution:
    def countQuadruplets(self, nums: List[int]) -> int:
        n = len(nums)
        count = 0
        for j in range(1, n - 2):
            less_i = 0
            for i in range(j):
                if nums[i] < nums[j]:
                    less_i += 1
            greater_k = 0
            for k in range(j + 1, n - 1):
                if nums[k] > nums[j]:
                    greater_k += 1
            for l in range(j + 2, n):
                if nums[l] < nums[j]:
                    less_k = 0
                    for k in range(j + 1, l):
                        if nums[k] > nums[j]:
                            less_k += 1
                    count += less_i * less_k
        return count