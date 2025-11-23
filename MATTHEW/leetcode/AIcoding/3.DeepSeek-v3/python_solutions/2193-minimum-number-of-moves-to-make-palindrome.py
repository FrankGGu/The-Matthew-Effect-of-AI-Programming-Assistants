class Solution:
    def minMovesToMakePalindrome(self, s: str) -> int:
        res = 0
        s = list(s)
        left, right = 0, len(s) - 1

        while left < right:
            if s[left] == s[right]:
                left += 1
                right -= 1
                continue

            l, r = left, right
            while s[l] != s[right]:
                l += 1

            while s[r] != s[left]:
                r -= 1

            if (right - r) < (l - left):
                res += right - r
                for i in range(r, right):
                    s[i] = s[i + 1]
                s[right] = s[left]
            else:
                res += l - left
                for i in range(l, left, -1):
                    s[i] = s[i - 1]
                s[left] = s[right]

            left += 1
            right -= 1

        return res