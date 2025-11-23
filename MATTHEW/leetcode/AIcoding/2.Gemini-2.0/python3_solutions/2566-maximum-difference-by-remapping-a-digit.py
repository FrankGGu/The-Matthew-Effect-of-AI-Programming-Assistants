class Solution:
    def maxDiff(self, num: int) -> int:
        s = str(num)
        n = len(s)

        def calculate(s, a, b):
            t = list(s)
            for i in range(n):
                if t[i] == a:
                    t[i] = b
            return int("".join(t))

        max_num = 0
        min_num = float('inf')

        for i in range(n):
            digit = s[i]
            for j in range(10):
                max_num = max(max_num, calculate(s, digit, str(9)))
                if i == 0 and j == 0:
                    continue
                min_num = min(min_num, calculate(s, digit, str(j)))

            break

        return max_num - min_num