class Solution:
    def minFlips(self, s: str) -> int:
        n = len(s)
        s = s + s
        count1 = count2 = 0

        for i in range(n):
            if s[i] == '0':
                count1 += 1
            else:
                count2 += 1

        min_flips1 = count1
        min_flips2 = count2

        for i in range(n, 2 * n):
            if s[i] == '0':
                count1 += 1
            else:
                count2 += 1

            if s[i - n] == '0':
                count1 -= 1
            else:
                count2 -= 1

            min_flips1 = min(min_flips1, count1)
            min_flips2 = min(min_flips2, count2)

        return min(min_flips1, min_flips2)