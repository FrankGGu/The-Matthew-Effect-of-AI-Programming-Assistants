class Solution:
    def strWithout3a3b(self, a: int, b: int) -> str:
        res = []
        while a > 0 or b > 0:
            # Determine which character to prioritize based on counts
            # Default preference: 'a' if a >= b, else 'b'
            should_add_a_first = (a >= b)

            # Override default preference if it would lead to 'aaa' or 'bbb'
            # If we prefer 'a' but it would create 'aaa', then we must try 'b'
            if should_add_a_first and a > 0 and len(res) >= 2 and res[-1] == 'a' and res[-2] == 'a':
                should_add_a_first = False
            # If we prefer 'b' but it would create 'bbb', then we must try 'a'
            elif not should_add_a_first and b > 0 and len(res) >= 2 and res[-1] == 'b' and res[-2] == 'b':
                should_add_a_first = True

            # Now, try to append the character based on the final decision `should_add_a_first`
            # and ensure its count is positive.
            if should_add_a_first and a > 0:
                res.append('a')
                a -= 1
            elif b > 0:  # If we couldn't add 'a' (either a=0 or `should_add_a_first` became False), try 'b'
                res.append('b')
                b -= 1
            elif a > 0:  # This covers the case where `should_add_a_first` was False (preferred 'b'),
                         # but 'b' count is 0. So, we must add 'a' if available.
                res.append('a')
                a -= 1
            else:        # Both a and b are 0, or we are stuck (problem guarantees a solution, so this shouldn't be reached if a or b > 0).
                break

        return "".join(res)