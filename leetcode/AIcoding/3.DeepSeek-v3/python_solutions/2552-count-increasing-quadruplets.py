class Solution:
    def countQuadruplets(self, nums: List[int]) -> int:
        n = len(nums)
        res = 0
        for j in range(n):
            for k in range(j + 1, n):
                if nums[k] > nums[j]:
                    continue
                left = 0
                for i in range(j):
                    if nums[i] < nums[k]:
                        left += 1
                right = 0
                for l in range(k + 1, n):
                    if nums[l] > nums[j]:
                        right += 1
                res += left * right
        return res