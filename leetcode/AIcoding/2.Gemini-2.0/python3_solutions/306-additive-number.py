class Solution:
    def isAdditiveNumber(self, num: str) -> bool:
        n = len(num)

        def check(first, second, start):
            if start == n:
                return True

            third = str(first + second)
            if num[start:].startswith(third):
                return check(second, int(third), start + len(third))
            else:
                return False

        for i in range(1, n // 2 + 1):
            for j in range(1, (n - i) // 2 + 1):
                if (num[0] == '0' and i > 1) or (num[i] == '0' and j > 1):
                    continue
                first = int(num[:i])
                second = int(num[i:i + j])
                if check(first, second, i + j):
                    return True

        return False