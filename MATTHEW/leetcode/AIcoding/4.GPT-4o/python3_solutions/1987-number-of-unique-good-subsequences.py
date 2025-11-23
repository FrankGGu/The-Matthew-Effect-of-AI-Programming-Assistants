class Solution:
    def countGoodSubsequences(self, binary: str) -> int:
        mod = 10**9 + 7
        last = -1
        count = 0
        for i, ch in enumerate(binary):
            if ch == '1':
                count += pow(2, i - last - 1, mod)
                last = i
        if last == -1:
            return 0
        return (count + 1) % mod