import collections
import math

class Solution:
    def is_prime(self, num: int) -> bool:
        if num < 2:
            return False
        if num == 2 or num == 3:
            return True
        if num % 2 == 0 or num % 3 == 0:
            return False
        i = 5
        while i * i <= num:
            if num % i == 0 or num % (i + 2) == 0:
                return False
            i += 6
        return True

    def mostFrequentPrime(self, mat: list[list[int]]) -> int:
        m = len(mat)
        n = len(mat[0])

        prime_counts = collections.Counter()

        dr = [-1, -1, -1, 0, 0, 1, 1, 1]
        dc = [-1, 0, 1, -1, 1, -1, 0, 1]

        for r in range(m):
            for c in range(n):
                for i in range(8):
                    current_num = mat[r][c] 

                    next_r, next_c = r + dr[i], c + dc[i]

                    while 0 <= next_r < m and 0 <= next_c < n:
                        current_num = current_num * 10 + mat[next_r][next_c]

                        if self.is_prime(current_num):
                            prime_counts[current_num] += 1

                        next_r += dr[i]
                        next_c += dc[i]

        if not prime_counts:
            return -1

        max_freq = 0
        result_prime = -1

        for prime, freq in prime_counts.items():
            if freq > max_freq:
                max_freq = freq
                result_prime = prime
            elif freq == max_freq:
                result_prime = max(result_prime, prime)

        return result_prime