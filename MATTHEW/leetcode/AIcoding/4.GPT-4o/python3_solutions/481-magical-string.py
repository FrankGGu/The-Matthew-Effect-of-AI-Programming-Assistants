class Solution:
    def magicalString(self, n: int) -> int:
        if n == 0:
            return 0
        elif n <= 3:
            return 1

        s = [1, 2, 2]
        count = 1
        idx = 2

        while len(s) < n:
            next_num = 1 if s[-1] == 2 else 2
            for _ in range(s[idx]):
                s.append(next_num)
                if len(s) == n:
                    break
            idx += 1

        return s[:n].count(1)