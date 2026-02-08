class Solution:
    def matrixSum(self, nums: List[List[int]]) -> int:
        for i in range(len(nums)):
            nums[i].sort(reverse=True)

        ans = 0
        for j in range(len(nums[0])):
            max_val = 0
            for i in range(len(nums)):
                if j < len(nums[i]):
                    max_val = max(max_val, nums[i][j])
            ans += max_val

        return ans