class Solution:
    def countKReducibleNumbers(self, N: int, K: int) -> int:
        def is_k_reducible(num):
            s = str(num)
            return all(s.count(c) <= K for c in set(s))

        count = 0
        for i in range(N):
            if is_k_reducible(i):
                count += 1
        return count