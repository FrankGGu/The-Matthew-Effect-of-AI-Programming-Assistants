class Solution:
    def numberOfPowerfulInt(self, start: int, finish: int, limit: int, s: str) -> int:
        def count(high):
            s_len = len(s)
            high_str = str(high)
            n = len(high_str)
            if n < s_len:
                return 0
            dp = {}

            def dfs(pos, tight, isLeading):
                if pos == n:
                    return 0 if isLeading else 1
                key = (pos, tight, isLeading)
                if key in dp:
                    return dp[key]
                max_digit = int(high_str[pos]) if tight else 9
                if isLeading:
                    res = dfs(pos + 1, tight and (0 == max_digit), True)
                    for d in range(1, min(max_digit, limit) + 1):
                        res += dfs(pos + 1, tight and (d == max_digit), False)
                else:
                    if n - pos > s_len:
                        res = 0
                        for d in range(0, min(max_digit, limit) + 1):
                            res += dfs(pos + 1, tight and (d == max_digit), False)
                    else:
                        idx = pos - (n - s_len)
                        required = int(s[idx])
                        if required > min(max_digit, limit):
                            res = 0
                        else:
                            res = dfs(pos + 1, tight and (required == max_digit), False)
                dp[key] = res
                return res

            return dfs(0, True, True)

        return count(finish) - count(start - 1)