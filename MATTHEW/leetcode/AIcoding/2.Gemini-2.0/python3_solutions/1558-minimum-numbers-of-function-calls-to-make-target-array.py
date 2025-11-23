class Solution:
    def minOperations(self, nums: List[int]) -> int:
        ans = 0
        mx = 0
        while True:
            zero = True
            for i in range(len(nums)):
                if nums[i] % 2 != 0:
                    nums[i] -= 1
                    ans += 1
                if nums[i] != 0:
                    zero = False
            if zero:
                break
            for i in range(len(nums)):
                nums[i] //= 2
            ans += 1
        return ans