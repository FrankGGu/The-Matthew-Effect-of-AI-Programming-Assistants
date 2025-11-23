class Solution:
    def largestNumber(self, cost: List[int], target: int) -> str:
        from functools import lru_cache

        @lru_cache(None)
        def dp(t):
            if t == 0:
                return ""
            max_num = ""
            for i in range(9, -1, -1):
                if t >= i + 1 and cost[i] <= t:
                    sub = dp(t - cost[i])
                    if sub != "-1":
                        candidate = str(i + 1) + sub
                        if len(candidate) > len(max_num) or (len(candidate) == len(max_num) and candidate > max_num):
                            max_num = candidate
            return max_num if max_num else "-1"

        result = dp(target)
        return result if result != "-1" else ""