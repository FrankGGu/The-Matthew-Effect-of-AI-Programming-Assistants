class Solution:

    def encrypt(self, strs: List[str]) -> str:
        return ''.join(f"{len(s)}#{s}" for s in strs)

    def decrypt(self, s: str) -> List[str]:
        res, i = [], 0
        while i < len(s):
            j = s.index('#', i)
            length = int(s[i:j])
            res.append(s[j + 1:j + 1 + length])
            i = j + 1 + length
        return res