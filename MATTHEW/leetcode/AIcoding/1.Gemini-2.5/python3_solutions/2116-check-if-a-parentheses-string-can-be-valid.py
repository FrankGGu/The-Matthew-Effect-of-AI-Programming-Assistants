class Solution:
    def canBeValid(self, s: str, locked: str) -> bool:
        n = len(s)

        if n % 2 != 0:
            return False

        # Left-to-right pass: check if we can maintain a non-negative balance
        # 'lo' represents the minimum possible balance (by treating '0's as ')')
        # 'hi' represents the maximum possible balance (by treating '0's as '(')
        lo = 0
        hi = 0
        for i in range(n):
            if locked[i] == '1':  # Fixed character
                if s[i] == '(':
                    lo += 1
                    hi += 1
                else:  # s[i] == ')'
                    lo -= 1
                    hi -= 1
            else:  # locked[i] == '0', flexible character (can be '(' or ')')
                lo -= 1  # Assume '0' is ')' to minimize balance
                hi += 1  # Assume '0' is '(' to maximize balance

            # The balance cannot drop below 0 for a valid prefix.
            # If 'lo' drops below 0, it means even with optimal use of flexible '0's as '(',
            # the balance would be negative. However, we can use a '0' to make it '(',
            # effectively bringing 'lo' back to 0. This is possible as long as 'hi' is not negative.
            lo = max(lo, 0)

            # If 'hi' becomes negative, it means even if all flexible '0's are used as '(',
            # we still have too many ')' that cannot be balanced.
            # So, it's impossible to form a valid string.
            if hi < 0:
                return False

        # After the left-to-right pass, 'lo' must be 0.
        # If 'lo > 0', it means even if all flexible '0's were used as ')',
        # we still have an excess of '(' that cannot be balanced to reach a final balance of 0.
        # This condition ensures that a total balance of 0 is achievable.
        return lo == 0