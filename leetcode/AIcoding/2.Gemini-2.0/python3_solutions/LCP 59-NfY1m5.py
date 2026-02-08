def minCost(stones):
    n = len(stones)
    stones.sort()
    dp = {}

    def solve(left, right):
        if (left, right) in dp:
            return dp[(left, right)]

        if left == right:
            return 0

        if left + 1 == right:
            return stones[right] + stones[left]

        res = float('inf')
        for i in range(left, right):
            res = min(res, solve(left, i) + solve(i + 1, right))

        dp[(left, right)] = res + stones[right] + stones[left]
        return dp[(left, right)]

    return solve(0, n - 1)