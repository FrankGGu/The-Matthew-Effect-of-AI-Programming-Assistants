class Solution:
    def minFlips(self, s: str) -> int:
        n = len(s)
        even = 0
        odd = 0
        for i in range(n):
            if i % 2 == 0:
                if s[i] != '0':
                    even += 1
            else:
                if s[i] != '1':
                    even += 1
        for i in range(n):
            if i % 2 == 0:
                if s[i] != '1':
                    odd += 1
            else:
                if s[i] != '0':
                    odd += 1
        res = min(even, odd)
        for i in range(n):
            if i % 2 == 0:
                if s[i] != '0':
                    even -= 1
                if s[i] != '1':
                    odd -= 1
            else:
                if s[i] != '1':
                    even -= 1
                if s[i] != '0':
                    odd -= 1
            if i + 1 < n:
                if (i + 1) % 2 == 0:
                    if s[i + 1] != '0':
                        even += 1
                    if s[i + 1] != '1':
                        odd += 1
                else:
                    if s[i + 1] != '1':
                        even += 1
                    if s[i + 1] != '0':
                        odd += 1
            res = min(res, even, odd)
        return res