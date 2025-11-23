class Solution:
    def countSteppingNumbers(self, low: int, high: int) -> int:
        def count(num):
            s = str(num)
            n = len(s)
            memo = {}

            def dp(idx, prev_digit, is_leading_zero, is_bound):
                if idx == n:
                    return 1

                if (idx, prev_digit, is_leading_zero, is_bound) in memo:
                    return memo[(idx, prev_digit, is_leading_zero, is_bound)]

                ans = 0
                upper_bound = int(s[idx]) if is_bound else 9

                for digit in range(upper_bound + 1):
                    if not is_leading_zero and abs(digit - prev_digit) != 1:
                        continue

                    ans += dp(idx + 1, digit, is_leading_zero and digit == 0, is_bound and digit == upper_bound)

                memo[(idx, prev_digit, is_leading_zero, is_bound)] = ans
                return ans

            ans = 0
            for digit in range(1, 10):
                ans += dp(1, digit, False, digit == int(s[0]))
            ans += dp(1, 0, True, 0 == int(s[0])) if s[0] == '0' else 0

            return ans

        def is_stepping(n):
            s = str(n)
            for i in range(len(s) - 1):
                if abs(int(s[i]) - int(s[i+1])) != 1:
                    return False
            return True

        return count(high) - count(low) + is_stepping(low)