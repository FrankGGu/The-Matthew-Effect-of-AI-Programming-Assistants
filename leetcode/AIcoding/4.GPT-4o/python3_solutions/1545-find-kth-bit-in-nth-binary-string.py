class Solution:
    def findKthBit(self, n: int, k: int) -> str:
        def generate(n):
            if n == 1:
                return "0"
            prev = generate(n - 1)
            return prev + "1" + ''.join('0' if bit == '1' else '1' for bit in reversed(prev))

        s = generate(n)
        return s[k - 1]