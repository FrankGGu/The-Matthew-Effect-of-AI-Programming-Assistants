class Solution:
    def countTriplets(self, n: int) -> int:
        count = 0
        for a in range(1, n + 1):
            for b in range(a, n + 1):
                c_square = a * a + b * b
                c = int(c_square**0.5)
                if c * c == c_square and c <= n:
                    count += 1 if a == b else 2
        return count