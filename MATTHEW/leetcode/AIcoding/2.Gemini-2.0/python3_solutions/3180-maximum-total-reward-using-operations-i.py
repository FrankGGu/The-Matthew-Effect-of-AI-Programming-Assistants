def maxReward(operations, coins, k):
    n = len(operations)
    dp = {}

    def solve(idx, c):
        if idx == n:
            return 0

        if (idx, c) in dp:
            return dp[(idx, c)]

        op_type, op_val = operations[idx]

        res = 0
        if op_type == 0:
            res = max(res, solve(idx + 1, min(coins, c + op_val)))
        else:
            take = (coins // (2 ** op_val)) - (c // (2 ** op_val)) + k + solve(idx + 1, c)
            skip = solve(idx + 1, c)
            res = max(take, skip)

        dp[(idx, c)] = res
        return res

    return solve(0, 0)