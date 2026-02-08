class Solution:
    def countPalindromicSubsequence(self, s: str) -> int:
        res = 0
        for c in set(s):
            left = s.find(c)
            right = s.rfind(c)
            if left != -1 and right != -1 and left < right:
                res += len(set(s[left+1:right]))
        return res