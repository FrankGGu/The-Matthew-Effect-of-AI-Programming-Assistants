class Solution:
    def magicalString(self, n: int) -> int:
        if n == 0:
            return 0
        if n <= 3:
            return 1

        s = [1, 2, 2]
        head = 2
        res = 1
        num = 1

        while len(s) < n:
            for _ in range(s[head]):
                s.append(num)
                if num == 1 and len(s) <= n:
                    res += 1
            num ^= 3
            head += 1

        return res