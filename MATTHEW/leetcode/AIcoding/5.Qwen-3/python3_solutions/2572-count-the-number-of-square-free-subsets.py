class Solution:
    def squareFreeSubsets(self, nums: List[int]) -> int:
        from collections import defaultdict

        def is_square_free(n):
            for i in range(2, int(n**0.5) + 1):
                if n % (i * i) == 0:
                    return False
            return True

        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
        prime_index = {p: i for i, p in enumerate(primes)}

        dp = defaultdict(int)
        dp[0] = 1

        for num in nums:
            if not is_square_free(num):
                continue
            mask = 0
            for p in primes:
                if num % p == 0:
                    cnt = 0
                    temp = num
                    while temp % p == 0:
                        temp //= p
                        cnt += 1
                    if cnt >= 2:
                        mask = -1
                        break
                    mask |= 1 << prime_index[p]
            if mask == -1:
                continue
            new_dp = dp.copy()
            for key in dp:
                if (key & mask) == 0:
                    new_dp[key | mask] += dp[key]
            dp = new_dp

        return sum(dp.values()) - 1