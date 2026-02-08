class Solution:
    def countNonSpecialNumbers(self, n: int) -> int:
        def countSpecialNumbers(x):
            s = str(x)
            length = len(s)
            used = set()
            total = 0

            for i in range(1, length):
                total += 9 * (9 ** (i - 1))

            for i in range(length):
                for j in range(i == 0, 10):
                    if j in used:
                        continue
                    if j == 0 and i == 0:
                        continue
                    if j < int(s[i]):
                        total += 9 ** (length - i - 1) * (9 - i)
                        break
                    elif j == int(s[i]):
                        used.add(j)
                        if i == length - 1:
                            total += 1
                        break

            return total

        return n - countSpecialNumbers(n)