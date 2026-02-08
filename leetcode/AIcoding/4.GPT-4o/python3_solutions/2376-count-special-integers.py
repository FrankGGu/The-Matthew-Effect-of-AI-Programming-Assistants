class Solution:
    def countSpecialNumbers(self, n: int) -> int:
        s = str(n)
        length = len(s)
        count = 0

        # Count numbers with fewer digits
        for i in range(1, length):
            count += 9 * perm(9, i - 1)

        # Count numbers with the same number of digits
        seen = set()
        for i in range(length):
            for j in range(1 if i == 0 else 0, int(s[i])):
                if j not in seen:
                    count += perm(9 - i, length - i - 1)
            if s[i] in seen:
                break
            seen.add(s[i])

        return count + 1

def perm(n, k):
    if k == 0:
        return 1
    res = 1
    for i in range(k):
        res *= n - i
    return res