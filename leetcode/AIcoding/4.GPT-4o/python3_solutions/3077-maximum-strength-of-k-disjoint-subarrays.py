class Solution:
    def maxStrength(self, nums: List[int], k: int) -> int:
        nums.sort()
        n = len(nums)
        if k == n:
            return reduce(operator.mul, nums, 1)

        product = 1
        cnt = 0

        for i in range(n-1, -1, -1):
            if nums[i] > 0 and cnt < k:
                product *= nums[i]
                cnt += 1
            elif nums[i] < 0 and cnt < k-1:
                product *= nums[i]
                cnt += 1

        if cnt < k:
            return 0

        return product