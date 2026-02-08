class Solution:
    def minSwaps(self, s: str) -> int:
        balance = 0
        unmatched_closing_brackets = 0

        for char in s:
            if char == '[':
                balance += 1
            else:  # char == ']'
                balance -= 1
                if balance < 0:
                    unmatched_closing_brackets += 1
                    # If balance drops below zero, it means we encountered a ']'
                    # that cannot be matched by any preceding '['.
                    # This ']' is "out of place" and needs a swap.
                    # Conceptually, we swap this ']' with a '[' from later in the string.
                    # After this conceptual swap, this position effectively becomes a '['
                    # for the purpose of balancing subsequent characters.
                    # Thus, we reset balance to 0 to reflect this "fix".
                    balance = 0

        # Each swap can resolve two such mismatches:
        # one ']' that appeared too early (making balance negative)
        # and one '[' that appeared too late (which would have been used for the swap).
        # Therefore, if 'k' is the total count of such 'unmatched_closing_brackets',
        # the minimum number of swaps needed is ceil(k / 2).
        # In integer arithmetic, ceil(k / 2) can be calculated as (k + 1) // 2.
        return (unmatched_closing_brackets + 1) // 2