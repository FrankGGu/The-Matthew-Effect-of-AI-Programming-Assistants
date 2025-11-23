class Solution:
    def possiblyEquals(self, s1: str, s2: str) -> bool:
        from functools import lru_cache

        def get_possible_lengths(s):
            res = {int(s)}
            for i in range(1, len(s)):
                res |= {x + y for x in get_possible_lengths(s[:i]) for y in get_possible_lengths(s[i:])}
            return res

        @lru_cache(maxsize=None)
        def dfs(i, j, diff):
            if i == len(s1) and j == len(s2):
                return diff == 0
            if i < len(s1) and s1[i].isdigit():
                k = i
                while k < len(s1) and s1[k].isdigit():
                    k += 1
                for l in get_possible_lengths(s1[i:k]):
                    if dfs(k, j, diff - l):
                        return True
                return False
            elif j < len(s2) and s2[j].isdigit():
                k = j
                while k < len(s2) and s2[k].isdigit():
                    k += 1
                for l in get_possible_lengths(s2[j:k]):
                    if dfs(i, k, diff + l):
                        return True
                return False
            elif diff == 0:
                if i < len(s1) and j < len(s2) and s1[i] == s2[j]:
                    return dfs(i + 1, j + 1, 0)
                else:
                    return False
            elif diff > 0:
                if i < len(s1):
                    return dfs(i + 1, j, diff - 1)
                else:
                    return False
            else:
                if j < len(s2):
                    return dfs(i, j + 1, diff + 1)
                else:
                    return False

        return dfs(0, 0, 0)