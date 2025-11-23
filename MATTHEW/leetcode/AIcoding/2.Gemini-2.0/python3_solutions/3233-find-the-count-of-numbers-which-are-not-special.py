def countSpecialNumbers(n: int) -> int:
    s = str(n)
    m = len(s)
    dp = {}

    def dfs(i, mask, is_limit, is_num):
        if i == m:
            return 1 if is_num else 0
        if (i, mask, is_limit, is_num) in dp:
            return dp[(i, mask, is_limit, is_num)]

        res = 0
        if not is_num:
            res += dfs(i + 1, mask, False, False)

        up = int(s[i]) if is_limit else 9
        for d in range(1 if not is_num else 0, up + 1):
            if (mask >> d) & 1 == 0:
                res += dfs(i + 1, mask | (1 << d), is_limit and d == up, True)

        dp[(i, mask, is_limit, is_num)] = res
        return res

    return dfs(0, 0, True, False)