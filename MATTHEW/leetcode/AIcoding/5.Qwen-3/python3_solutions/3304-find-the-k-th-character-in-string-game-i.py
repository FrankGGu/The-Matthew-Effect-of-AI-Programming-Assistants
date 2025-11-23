class Solution:
    def kthCharacter(self, s: str, k: int) -> str:
        def generate(s):
            res = []
            for c in s:
                res.append(c)
                res.append(chr(ord(c) + 1))
            return ''.join(res)

        while len(s) < k:
            s = generate(s)

        return s[k-1]