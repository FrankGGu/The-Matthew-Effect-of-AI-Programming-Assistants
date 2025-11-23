class Solution:
    def minOperations(self, grid: List[List[int]], k: int) -> int:
        from collections import Counter

        def get_gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        def get_lcm(a, b):
            return a * b // get_gcd(a, b)

        flat = [num for row in grid for num in row]
        counts = Counter(flat)
        values = list(counts.keys())
        values.sort()

        res = 0
        for v in values:
            if v % k != 0:
                res += counts[v]
        return res