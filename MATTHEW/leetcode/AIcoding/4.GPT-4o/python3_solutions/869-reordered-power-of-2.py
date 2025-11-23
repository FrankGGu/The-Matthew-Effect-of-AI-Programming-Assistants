class Solution:
    def reorderedPowerOf2(self, N: int) -> bool:
        from collections import Counter

        def count_digits(n):
            return Counter(str(n))

        return count_digits(N) in (count_digits(1 << i) for i in range(30))