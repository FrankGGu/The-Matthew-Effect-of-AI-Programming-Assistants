class Solution:
    def numWays(self, s: str) -> int:
        MOD = 10**9 + 7
        count = 0
        for c in s:
            if c == '1':
                count += 1
        if count < 2:
            return 0
        if count % 2 != 0:
            return 0
        half = count // 2
        first = 0
        second = 0
        for c in s:
            if c == '1':
                first += 1
                if first == half:
                    second += 1
        return second % MOD