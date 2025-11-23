class Solution:
    def addMinimum(self, word: str) -> int:
        additions = 0
        # expected_state represents the character we are currently looking for in the 'abc' cycle.
        # 0 for 'a', 1 for 'b', 2 for 'c'.
        expected_state = 0 

        for char_in_word in word:
            char_val = ord(char_in_word) - ord('a')

            if char_val == expected_state:
                # Matched the character we were looking for.
                # Advance the state to the next character in the 'abc' cycle.
                expected_state = (expected_state + 1) % 3
            elif char_val == (expected_state + 1) % 3:
                # We found the character that is one step ahead of what we expected.
                # This means we implicitly had to add the 'expected_state' character.
                # Then we matched the current 'char_in_word'.
                # Now, advance the state two steps (one for the added char, one for the matched char).
                additions += 1
                expected_state = (expected_state + 2) % 3
            else: # char_val == (expected_state + 2) % 3
                # We found the character that is two steps ahead of what we expected.
                # This means we implicitly had to add 'expected_state' and the character after it.
                # Then we matched the current 'char_in_word'.
                # Now, advance the state three steps (two for added chars, one for matched char),
                # which effectively resets it to 0 for the start of a new 'abc' cycle.
                additions += 2
                expected_state = (expected_state + 3) % 3 # This is equivalent to expected_state = 0

        # After iterating through the entire word, we might still need to complete
        # the current 'abc' sequence based on the final expected_state.
        # If expected_state is 0, we ended perfectly on 'c' (or an empty string), so 0 additions needed.
        # If expected_state is 1, we need 'b' and 'c', so 2 additions.
        # If expected_state is 2, we need 'c', so 1 addition.
        additions += (3 - expected_state) % 3

        return additions