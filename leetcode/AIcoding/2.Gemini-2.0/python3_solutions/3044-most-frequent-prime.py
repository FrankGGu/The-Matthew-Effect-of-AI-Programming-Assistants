class Solution:
    def mostFrequentPrime(self, mat: List[List[int]]) -> int:
        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n**0.5) + 1):
                if n % i == 0:
                    return False
            return True

        def get_numbers(row, col, dr, dc):
            num = 0
            while 0 <= row < m and 0 <= col < n:
                num = num * 10 + mat[row][col]
                if num > 10 and is_prime(num):
                    primes.add(num)
                row += dr
                col += dc

        m, n = len(mat), len(mat[0])
        primes = set()

        for i in range(m):
            for j in range(n):
                if mat[i][j] > 1:
                    get_numbers(i, j, 0, 1)
                    get_numbers(i, j, 1, 0)
                    get_numbers(i, j, 1, 1)
                    get_numbers(i, j, 1, -1)

        counts = {}
        for prime in primes:
            counts[prime] = 0

        for i in range(m):
            for j in range(n):
                get_numbers(i, j, 0, 1)
                get_numbers(i, j, 1, 0)
                get_numbers(i, j, 1, 1)
                get_numbers(i, j, 1, -1)

        primes = list(primes)
        for i in range(m):
            for j in range(n):
              for dr, dc in [(0, 1), (1, 0), (1, 1), (1, -1)]:
                num = 0
                r, c = i, j
                while 0 <= r < m and 0 <= c < n:
                    num = num * 10 + mat[r][c]
                    if num in counts:
                        counts[num] += 1
                    r += dr
                    c += dc

        max_count = 0
        result = -1
        for prime in sorted(counts.keys(), reverse = True):
          if counts[prime] > max_count:
            max_count = counts[prime]
            result = prime

        return result