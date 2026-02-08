class Solution:
    def findMirrorScore(self, s: str) -> int:
        mirror = {'A':'A', 'H':'H', 'I':'I', 'M':'M', 'O':'O', 'T':'T', 'U':'U', 'V':'V', 'W':'W', 'X':'X', 'Y':'Y', 'b':'d', 'd':'b', 'o':'o', 'p':'q', 'q':'p', 'v':'v', 'w':'w', 'x':'x'}
        n = len(s)
        score = 0
        for i in range((n + 1) // 2):
            left = s[i]
            right = s[n - 1 - i]
            if left in mirror and mirror[left] == right:
                score += 1
        return score