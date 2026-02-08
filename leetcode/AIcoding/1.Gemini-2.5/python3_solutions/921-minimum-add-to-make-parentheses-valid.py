class Solution:
    def minAddToMakeValid(self, s: str) -> int:
        balance = 0
        additions = 0

        for char in s:
            if char == '(':
                balance += 1
            else:  # char == ')'
                if balance > 0:
                    balance -= 1
                else:
                    # This ')' has no matching open parenthesis, so we need to add one.
                    additions += 1

        # Any remaining 'balance' means we have unmatched open parentheses,
        # each needing a closing parenthesis.
        additions += balance

        return additions