class Solution:
    def minMovesToMakePalindrome(self, s: str) -> int:
        s = list(s)
        ans = 0
        while len(s) > 0:
            i = 0
            while s[i] != s[-1]:
                i += 1
            if i == len(s) - 1:
                ans += len(s) // 2
            else:
                ans += i
                s.pop(i)
            s.pop()
        return ans