class Solution:
    def numWays(self, s: str) -> int:
        MOD = 10**9 + 7
        count_1 = s.count('1')
        if count_1 % 3 != 0:
            return 0
        if count_1 == 0:
            n = len(s)
            return (n - 1) * (n - 2) // 2 % MOD

        target = count_1 // 3
        current = 0
        first_end = 0
        second_start = 0
        for i, char in enumerate(s):
            if char == '1':
                current += 1
                if current == target:
                    first_end = i
                if current == target + 1:
                    second_start = i

        ways_first = second_start - first_end

        current = 0
        second_end = 0
        third_start = 0
        for i, char in enumerate(s):
            if char == '1':
                current += 1
                if current == 2 * target:
                    second_end = i
                if current == 2 * target + 1:
                    third_start = i

        ways_second = third_start - second_end

        return ways_first * ways_second % MOD