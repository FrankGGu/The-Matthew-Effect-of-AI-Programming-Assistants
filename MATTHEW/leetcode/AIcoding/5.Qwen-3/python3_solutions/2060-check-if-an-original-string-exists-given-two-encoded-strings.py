class Solution:
    def possiblyEquals(self, s: str, t: str) -> bool:
        from functools import lru_cache

        def getDigits(s):
            res = []
            i = 0
            while i < len(s):
                if s[i].isdigit():
                    j = i
                    while j < len(s) and s[j].isdigit():
                        j += 1
                    res.append(int(s[i:j]))
                    i = j
                else:
                    res.append(s[i])
                    i += 1
            return res

        s_digits = getDigits(s)
        t_digits = getDigits(t)

        @lru_cache(None)
        def dp(i, j, diff):
            if i == len(s_digits) and j == len(t_digits):
                return diff == 0
            if diff == 0:
                if i < len(s_digits) and j < len(t_digits):
                    if isinstance(s_digits[i], str) and isinstance(t_digits[j], str):
                        return s_digits[i] == t_digits[j] and dp(i + 1, j + 1, 0)
                    elif isinstance(s_digits[i], int) and isinstance(t_digits[j], int):
                        return dp(i + 1, j + 1, 0)
                    elif isinstance(s_digits[i], int) and isinstance(t_digits[j], str):
                        return dp(i + 1, j, s_digits[i])
                    elif isinstance(s_digits[i], str) and isinstance(t_digits[j], int):
                        return dp(i, j + 1, -t_digits[j])
                elif i < len(s_digits) and isinstance(s_digits[i], int):
                    return dp(i + 1, j, s_digits[i])
                elif j < len(t_digits) and isinstance(t_digits[j], int):
                    return dp(i, j + 1, -t_digits[j])
            else:
                if i < len(s_digits) and isinstance(s_digits[i], str):
                    if diff > 0:
                        return dp(i + 1, j, diff - 1)
                    else:
                        return dp(i + 1, j, diff + 1)
                elif j < len(t_digits) and isinstance(t_digits[j], str):
                    if diff > 0:
                        return dp(i, j + 1, diff - 1)
                    else:
                        return dp(i, j + 1, diff + 1)
                elif i < len(s_digits) and isinstance(s_digits[i], int):
                    return dp(i + 1, j, diff + s_digits[i])
                elif j < len(t_digits) and isinstance(t_digits[j], int):
                    return dp(i, j + 1, diff - t_digits[j])
            return False

        return dp(0, 0, 0)