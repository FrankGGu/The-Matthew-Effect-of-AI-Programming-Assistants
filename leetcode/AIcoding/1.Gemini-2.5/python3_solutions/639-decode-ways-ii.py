class Solution:
    def numDecodings(self, s: str) -> int:
        MOD = 10**9 + 7
        n = len(s)

        dp_i_minus_2 = 1

        if s[0] == '0':
            dp_i_minus_1 = 0
        elif s[0] == '*':
            dp_i_minus_1 = 9
        else:
            dp_i_minus_1 = 1

        if n == 1:
            return dp_i_minus_1

        for i in range(2, n + 1):
            c1 = s[i-1]
            c2 = s[i-2]

            dp_i = 0

            # Ways from single digit s[i-1]
            if c1 == '*':
                dp_i = (dp_i + 9 * dp_i_minus_1) % MOD
            elif c1 != '0':
                dp_i = (dp_i + dp_i_minus_1) % MOD

            # Ways from two digits s[i-2:i]
            ways_two = 0
            if c2 == '1':
                if c1 == '*':
                    ways_two = 9
                else:
                    ways_two = 1
            elif c2 == '2':
                if c1 == '*':
                    ways_two = 6
                elif c1 >= '0' and c1 <= '6':
                    ways_two = 1
            elif c2 == '*':
                if c1 == '*':
                    ways_two = 15
                elif c1 >= '0' and c1 <= '6':
                    ways_two = 2
                elif c1 >= '7' and c1 <= '9':
                    ways_two = 1

            dp_i = (dp_i + ways_two * dp_i_minus_2) % MOD

            dp_i_minus_2 = dp_i_minus_1
            dp_i_minus_1 = dp_i

        return dp_i_minus_1