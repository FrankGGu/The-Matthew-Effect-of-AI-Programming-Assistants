class Solution:
    def getLucky(self, s: str, k: int) -> int:
        num = ''.join(str(ord(c) - ord('a') + 1) for c in s)
        total = sum(int(d) for d in num)
        for _ in range(k - 1):
            total = sum(int(d) for d in str(total))
        return total