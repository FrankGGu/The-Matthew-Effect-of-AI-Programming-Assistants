class Solution:
    def zeroFilledSubarray(self, nums: list[int]) -> int:
        ans = 0
        count = 0
        for num in nums:
            if num == 0:
                count += 1
                ans += count
            else:
                count = 0
        return ans