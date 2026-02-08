class Solution:
    def findKthBit(self, n: int, k: int) -> str:
        s = "0"
        for _ in range(1, n):
            inverted = ''.join(['1' if c == '0' else '0' for c in s])
            s = s + "1" + inverted[::-1]
        return s[k-1]