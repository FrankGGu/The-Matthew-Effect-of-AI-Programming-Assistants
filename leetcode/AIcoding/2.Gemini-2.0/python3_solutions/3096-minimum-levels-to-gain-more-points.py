def min_levels(levels: list[int], points: list[int]) -> int:
    n = len(levels)
    dp = {}

    def solve(i, earned):
        if i == n:
            return 0
        if (i, earned) in dp:
            return dp[(i, earned)]

        if earned >= levels[i]:
            dp[(i, earned)] = min(solve(i + 1, earned - levels[i] + points[i]), solve(i + 1, earned))
            return dp[(i, earned)]
        else:
            dp[(i, earned)] = 1 + solve(i + 1, earned + points[i])
            return dp[(i, earned)]

    return solve(0, 0)