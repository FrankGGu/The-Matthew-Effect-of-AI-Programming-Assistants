class Solution:
    def minNumberOfSemesters(self, n: int, relations: List[List[int]], k: int) -> int:
        pre = [0] * n
        for u, v in relations:
            pre[v - 1] |= 1 << (u - 1)

        dp = [n] * (1 << n)
        dp[0] = 0

        for mask in range(1 << n):
            available = []
            for i in range(n):
                if not (mask & (1 << i)) and (pre[i] & mask) == pre[i]:
                    available.append(i)

            for courses in itertools.combinations(available, min(k, len(available))):
                new_mask = mask
                for course in courses:
                    new_mask |= 1 << course
                if dp[new_mask] > dp[mask] + 1:
                    dp[new_mask] = dp[mask] + 1

        return dp[(1 << n) - 1]