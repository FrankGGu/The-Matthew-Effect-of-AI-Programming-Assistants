import collections

class Solution:
    def repeatLimitedString(self, s: str, repeatLimit: int) -> str:
        char_counts = [0] * 26
        for char_code in map(ord, s):
            char_counts[char_code - ord('a')] += 1

        result = []

        # i is the index of the current largest character we are trying to append
        # It iterates from 'z' (25) down to 'a' (0)
        i = 25 

        while i >= 0:
            # If char_i is exhausted, move to the next smaller character
            if char_counts[i] == 0:
                i -= 1
                continue

            char_i = chr(ord('a') + i)

            # If the last character in result is char_i, we cannot append char_i directly
            # because it would exceed the repeatLimit if we just appended it `repeatLimit` times.
            # In this case, we must find a smaller character to break the sequence.
            if result and result[-1] == char_i:
                # Find the next largest available character (j < i)
                # This character will be appended once to break the sequence of char_i
                j = i - 1
                while j >= 0 and char_counts[j] == 0:
                    j -= 1

                if j < 0:
                    # No smaller character available. We cannot append char_i anymore.
                    # We are done constructing the string.
                    break
                else:
                    # Append char_j once.
                    result.append(chr(ord('a') + j))
                    char_counts[j] -= 1
                    # After appending char_j, we can try to append char_i again in the next iteration.
                    # So, 'i' remains the same.
            else:
                # The last character in result is different from char_i, or result is empty.
                # We can append char_i as many times as possible, up to repeatLimit.
                num_to_append = min(char_counts[i], repeatLimit)
                result.extend([char_i] * num_to_append)
                char_counts[i] -= num_to_append

                # If char_i is exhausted after appending, move to the next smaller character.
                # If not exhausted, it means we appended `repeatLimit` times, and `char_counts[i]` is still > 0.
                # In this case, in the next iteration, the `if result and result[-1] == char_i:` condition
                # will be met, forcing us to find a smaller character to break the sequence.
                if char_counts[i] == 0:
                    i -= 1

        return "".join(result)