class Solution:
    def maxHappyGroups(self, k: int, nums: List[int]) -> int:
        remainders = [0] * k
        for num in nums:
            remainders[num % k] += 1

        ans = remainders[0]
        remainders[0] = 0

        for i in range(1, (k + 1) // 2):
            pairs = min(remainders[i], remainders[k - i])
            ans += pairs
            remainders[i] -= pairs
            remainders[k - i] -= pairs

        if k % 2 == 0:
            ans += remainders[k // 2] > 0
            remainders[k // 2] = 0

        dp = {}

        def solve(state):
            if state in dp:
                return dp[state]

            res = 0
            rem = 0
            temp = list(state)

            for i in range(1, k):
                rem = (rem + i * temp[i]) % k

            if rem == 0:
                res = 1

            best = 0

            for i in range(1, k):
                if temp[i] > 0:
                    temp[i] -= 1
                    new_state = tuple(temp)
                    best = max(best, solve(new_state))
                    temp[i] += 1

            res += best
            dp[state] = res
            return res

        state = tuple(remainders)
        ans += solve(state)

        return ans