import collections

class Solution:
    def equalFrequency(self, word: str) -> bool:
        char_counts = collections.Counter(word)
        freq_counts = collections.Counter(char_counts.values())

        if len(freq_counts) == 1:
            # All characters initially have the same frequency.
            # freq_counts = {frequency_value: count_of_that_frequency}
            # Example: "abc" -> {'a':1, 'b':1, 'c':1} -> freq_counts={1:3}
            # Example: "aaaa" -> {'a':4} -> freq_counts={4:1}

            # If the frequency itself is 1 (e.g., "abc", {1:3}), removing any char leaves all remaining with freq 1.
            # If there's only one distinct character (e.g., "aaaa", {4:1}), removing one instance leaves it with freq (4-1)=3.
            # Otherwise (e.g., "aabbcc", {2:3}), removing one 'a' makes it {'a':1, 'b':2, 'c':2}, not equal.
            f, c = next(iter(freq_counts.items()))
            return f == 1 or c == 1

        elif len(freq_counts) == 2:
            # There are two distinct frequencies among characters.
            # freq_counts = {f1: c1, f2: c2}
            # Unpack the two (frequency, count_of_frequency) pairs
            (f1, c1), (f2, c2) = freq_counts.items()

            # Scenario 1: One of the frequencies is 1, and it appears only once.
            # Example: "aabbc" -> {'a':2, 'b':2, 'c':1} -> freq_counts={2:2, 1:1}
            # If we remove the character with frequency 1 ('c'), then 'a' and 'b' both have frequency 2.
            if (f1 == 1 and c1 == 1) or (f2 == 1 and c2 == 1):
                return True

            # Scenario 2: One frequency (f_high) is exactly one greater than the other (f_low),
            # and f_high appears only once.
            # Example: "aabbb" -> {'a':2, 'b':3} -> freq_counts={2:1, 3:1}
            # If we remove one instance of the character with frequency 3 ('b'),
            # then 'a' and 'b' both have frequency 2.
            if (f1 == f2 + 1 and c1 == 1) or (f2 == f1 + 1 and c2 == 1):
                return True

            return False

        else: # len(freq_counts) > 2
            # If there are more than two distinct frequencies (e.g., {3:1, 2:1, 1:1} for "aaabbc"),
            # it's impossible to make all frequencies equal by removing just one character.
            return False