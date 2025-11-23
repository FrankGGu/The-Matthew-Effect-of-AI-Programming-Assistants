class Solution:
    def findKthCharacter(self, s: str, k: int) -> str:
        while len(s) < k:
            new_s = []
            for c in s:
                if c == '0':
                    new_s.append('01')
                else:
                    new_s.append('10')
            s = ''.join(new_s)
        return s[k-1]