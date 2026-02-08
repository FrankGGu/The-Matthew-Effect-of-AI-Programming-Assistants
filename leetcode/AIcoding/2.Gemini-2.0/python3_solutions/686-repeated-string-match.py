class Solution:
    def repeatedStringMatch(self, a: str, b: str) -> int:
        n = len(a)
        m = len(b)

        for i in range(n):
            count = 1
            temp = a[i:] + a[:i]
            while len(temp) < m:
                temp += a
                count += 1

            if b in temp:
                return count

            temp += a
            count += 1

            if b in temp:
                return count

        return -1