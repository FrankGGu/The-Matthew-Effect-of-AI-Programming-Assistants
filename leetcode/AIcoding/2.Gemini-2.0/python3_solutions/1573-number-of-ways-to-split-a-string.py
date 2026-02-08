class Solution:
    def numWays(self, s: str) -> int:
        n = len(s)
        ones = s.count('1')

        if ones % 3 != 0:
            return 0

        if ones == 0:
            return (n - 1) * (n - 2) // 2 % (10**9 + 7)

        target = ones // 3

        first_cut_options = 0
        second_cut_options = 0

        count = 0
        for i in range(n):
            if s[i] == '1':
                count += 1
            if count == target:
                first_cut_options += 1
            elif count == 2 * target:
                second_cut_options += 1

        return (first_cut_options * second_cut_options) % (10**9 + 7)