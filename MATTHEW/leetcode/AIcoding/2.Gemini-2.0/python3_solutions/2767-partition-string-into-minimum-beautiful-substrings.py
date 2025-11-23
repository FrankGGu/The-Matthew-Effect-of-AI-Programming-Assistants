class Solution:
    def beautifulPartitions(self, s: str, k: int, minLength: int) -> int:
        def is_prime(num):
            if num < 2:
                return False
            for i in range(2, int(num**0.5) + 1):
                if num % i == 0:
                    return False
            return True

        def is_beautiful(char):
            return char in '2357'

        n = len(s)
        if not is_beautiful(s[0]) or not is_beautiful(s[-1]):
            return 0

        primes = [i for i in range(2, 10) if is_prime(i)]

        dp = {}

        def solve(index, partitions):
            if index == n:
                return 1 if partitions == k else 0

            if partitions > k:
                return 0

            if (index, partitions) in dp:
                return dp[(index, partitions)]

            ans = 0
            for j in range(index + minLength, n + 1):
                sub = s[index:j]
                if is_beautiful(sub[0]) and (j == n or is_beautiful(s[j])):
                    ans = (ans + solve(j, partitions + 1)) % (10**9 + 7)

            dp[(index, partitions)] = ans
            return ans

        result = solve(0, 0)
        return result if result != 0 else 0