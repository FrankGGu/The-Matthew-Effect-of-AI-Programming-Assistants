class Solution:
    def minFlips(self, s: str) -> int:
        n = len(s)
        s = s + s
        target1 = []
        target2 = []
        for i in range(len(s)):
            target1.append('0' if i % 2 == 0 else '1')
            target2.append('1' if i % 2 == 0 else '0')

        diff1 = 0
        diff2 = 0
        res = float('inf')
        left = 0

        for right in range(len(s)):
            if s[right] != target1[right]:
                diff1 += 1
            if s[right] != target2[right]:
                diff2 += 1

            if right >= n:
                if s[left] != target1[left]:
                    diff1 -= 1
                if s[left] != target2[left]:
                    diff2 -= 1
                left += 1
                if right - left + 1 == n:
                    res = min(res, diff1, diff2)

        return res