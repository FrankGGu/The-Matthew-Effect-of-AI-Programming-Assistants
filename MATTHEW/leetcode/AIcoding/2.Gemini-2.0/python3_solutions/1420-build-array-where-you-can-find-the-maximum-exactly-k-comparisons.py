MOD = 10**9 + 7

def numOfArrays(n: int, m: int, k: int) -> int:
    dp = {}

    def solve(idx, remain, max_so_far):
        if idx == n:
            if remain == 0:
                return 1
            else:
                return 0

        if (idx, remain, max_so_far) in dp:
            return dp[(idx, remain, max_so_far)]

        ans = 0
        for num in range(1, m + 1):
            if num > max_so_far:
                if remain > 0:
                    ans = (ans + solve(idx + 1, remain - 1, num)) % MOD
            else:
                ans = (ans + solve(idx + 1, remain, max_so_far)) % MOD

        dp[(idx, remain, max_so_far)] = ans
        return ans

    return solve(0, k, 0)