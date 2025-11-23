class Solution:
    def countPalindromes(self, n: int) -> int:
        count = 0
        mod = 10**9 + 7
        for length in range(1, 6):
            if n < length * 2:
                break
            for prefix in range(1, 10):
                for middle in range(10):
                    total_length = length * 2
                    if total_length <= n:
                        count += 1
                    if n > total_length:
                        count += 9 * pow(10, (n - total_length - 1) // 2, mod)
                    count %= mod
        return count