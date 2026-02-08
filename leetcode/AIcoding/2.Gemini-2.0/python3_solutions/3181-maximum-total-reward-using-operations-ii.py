def maxReward(n, ops, rewards):
    dp = {}

    def solve(index, k):
        if (index, k) in dp:
            return dp[(index, k)]

        if index == n:
            return 0

        res = solve(index + 1, k)

        if ops[index] <= k:
            res = max(res, rewards[index] + solve(index + 1, k - ops[index]))

        dp[(index, k)] = res
        return res

    return solve(0, sum(ops))