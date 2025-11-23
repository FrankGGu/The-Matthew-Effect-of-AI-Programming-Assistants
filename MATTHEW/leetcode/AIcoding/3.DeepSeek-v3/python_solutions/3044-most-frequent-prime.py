class Solution:
    def mostFrequentPrime(self, mat: List[List[int]]) -> int:
        from collections import defaultdict

        directions = [
            (0, 1),   # right
            (1, 0),   # down
            (0, -1),  # left
            (-1, 0),  # up
            (1, 1),    # down-right
            (1, -1),   # down-left
            (-1, 1),   # up-right
            (-1, -1)   # up-left
        ]

        m, n = len(mat), len(mat[0])
        prime_counts = defaultdict(int)

        def is_prime(num):
            if num < 2:
                return False
            for i in range(2, int(num ** 0.5) + 1):
                if num % i == 0:
                    return False
            return True

        for i in range(m):
            for j in range(n):
                for di, dj in directions:
                    x, y = i, j
                    num = 0
                    while 0 <= x < m and 0 <= y < n:
                        num = num * 10 + mat[x][y]
                        if num > 10 and is_prime(num):
                            prime_counts[num] += 1
                        x += di
                        y += dj

        if not prime_counts:
            return -1

        max_count = max(prime_counts.values())
        candidates = [num for num, cnt in prime_counts.items() if cnt == max_count]
        return max(candidates) if candidates else -1