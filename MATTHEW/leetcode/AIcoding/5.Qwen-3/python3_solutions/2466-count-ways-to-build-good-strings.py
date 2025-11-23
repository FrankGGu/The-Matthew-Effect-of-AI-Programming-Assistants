class Solution:
    def countGoodStrings(self, minLength: int, maxLength: int, minCost: int, maxCost: int) -> int:
        dp = [0] * (maxCost + 1)
        dp[0] = 1
        for i in range(1, maxCost + 1):
            dp[i] = dp[i - 1]
            if i >= minCost and i <= maxCost:
                dp[i] += 1
        result = 0
        for length in range(minLength, maxLength + 1):
            temp = [0] * (maxCost + 1)
            temp[0] = 1
            for i in range(1, maxCost + 1):
                temp[i] = temp[i - 1]
                if i >= minCost and i <= maxCost:
                    temp[i] += 1
            for i in range(1, maxCost + 1):
                temp[i] = (temp[i] + temp[i - 1]) % (10**9 + 7)
            result = (result + temp[maxCost]) % (10**9 + 7)
        return result