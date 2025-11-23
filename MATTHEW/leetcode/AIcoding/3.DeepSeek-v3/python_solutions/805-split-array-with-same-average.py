class Solution:
    def splitArraySameAverage(self, nums: List[int]) -> bool:
        n = len(nums)
        total = sum(nums)
        dp = [set() for _ in range(n//2 + 1)]
        dp[0].add(0)

        for num in nums:
            for i in range(len(dp)-1, 0, -1):
                for val in dp[i-1]:
                    dp[i].add(val + num)

        for k in range(1, len(dp)):
            if total * k % n == 0:
                target = total * k // n
                if target in dp[k]:
                    return True
        return False