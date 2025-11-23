class Solution:
    def countPalindromes(self, s: str) -> int:
        mod = 10**9 + 7
        n = len(s)
        count = 0

        for length in range(1, 6):
            freq = [0] * 10
            for i in range(n):
                if i >= length:
                    freq[int(s[i-length])] -= 1
                freq[int(s[i])] += 1
                if i >= length - 1:
                    count += self.calculate(freq) % mod
                    count %= mod

        return count

    def calculate(self, freq):
        odd_count = sum(1 for f in freq if f % 2 == 1)
        if odd_count > 1:
            return 0
        total_pairs = sum(f // 2 for f in freq)
        return self.factorial(total_pairs) % (10**9 + 7)

    def factorial(self, n):
        if n == 0 or n == 1:
            return 1
        result = 1
        for i in range(2, n + 1):
            result = (result * i) % (10**9 + 7)
        return result