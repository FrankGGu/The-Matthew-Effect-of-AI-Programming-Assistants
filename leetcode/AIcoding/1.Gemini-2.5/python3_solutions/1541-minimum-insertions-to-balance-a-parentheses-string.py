class Solution:
    def minInsertions(self, s: str) -> int:
        ans = 0
        left_open_needed = 0
        i = 0
        n = len(s)

        while i < n:
            if s[i] == '(':
                left_open_needed += 1
            else:  # s[i] == ')'
                # Check if this ')' can close an open '('
                if left_open_needed > 0:
                    left_open_needed -= 1
                else:
                    # No open '(' to match this ')', so we must insert one.
                    ans += 1

                # Now, this ')' is considered the first ')' of a required ')).
                # Check if the next character is also a ')'
                if i + 1 < n and s[i+1] == ')':
                    i += 1  # Consume the second ')'
                else:
                    # Only one ')' found, need to insert another ')'
                    ans += 1
            i += 1

        # After iterating through the string, any remaining 'left_open_needed'
        # means we need to insert ')' pairs for them. Each needs two ')'.
        ans += left_open_needed * 2

        return ans