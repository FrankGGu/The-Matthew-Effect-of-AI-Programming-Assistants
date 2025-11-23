class Solution:
    def findKthBit(self, n: int, k: int) -> str:
        def generate(s):
            if len(s) == 1:
                return s
            new_s = s + '1' + ''.join('1' if c == '0' else '0' for c in reversed(s))
            return new_s

        s = '0'
        for i in range(1, n):
            s = generate(s)
        return s[k-1]