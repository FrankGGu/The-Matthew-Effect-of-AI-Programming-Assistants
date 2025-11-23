class Solution:
    def numWays(self, s: str) -> int:
        mod = 10**9 + 7
        count = s.count('1')

        if count == 0:
            return (1 * (len(s) - 1) * (len(s) - 2) // 2) % mod
        if count % 3 != 0:
            return 0

        parts = count // 3
        first = second = 0
        for i in range(len(s)):
            if s[i] == '1':
                if first < parts:
                    first += 1
                elif second < parts:
                    second += 1

        first_count = second_count = 1
        for i in range(len(s)):
            if s[i] == '1':
                if first_count <= parts:
                    first_count += 1
                elif second_count <= parts:
                    second_count += 1
            elif first < parts:
                first_count += 1
                second_count += 1

        return (first_count * second_count) % mod