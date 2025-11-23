class Solution:
    def numberOfWays(self, nums: List[int]) -> int:
        first = -1
        last = -1
        for i in range(len(nums)):
            if nums[i] == 1:
                if first == -1:
                    first = i
                last = i
        if first == -1:
            return 0

        ans = 1
        prev = first
        for i in range(first + 1, last + 1):
            if nums[i] == 1:
                ans = (ans * (i - prev)) % (10**9 + 7)
                prev = i
        return ans