class Solution:
    def nthUglyNumber(self, n: int, a: int, b: int, c: int) -> int:
        def count(num):
            return num // a + num // b + num // c - num // (a * b // self.gcd(a, b)) - num // (a * c // self.gcd(a, c)) - num // (b * c // self.gcd(b, c)) + num // (a * b // self.gcd(a, b) * c // self.gcd(a * b // self.gcd(a, b), c))

        def gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        low, high = 1, 2 * 10**9
        while low < high:
            mid = low + (high - low) // 2
            if count(mid) < n:
                low = mid + 1
            else:
                high = mid
        return low