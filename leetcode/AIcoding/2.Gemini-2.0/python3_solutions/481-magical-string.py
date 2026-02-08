class Solution:
    def magicalString(self, n: int) -> int:
        if n == 0:
            return 0
        if n <= 3:
            return 1
        s = [1, 2, 2]
        i = 2
        j = 3
        while j < n:
            for _ in range(s[i]):
                s.append(3 - s[-1])
                j += 1
                if j >= n:
                    break
            i += 1
        return s[:n].count(1)