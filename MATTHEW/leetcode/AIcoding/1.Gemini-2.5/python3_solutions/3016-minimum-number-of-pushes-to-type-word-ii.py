import collections

class Solution:
    def minimumPushes(self, word: str) -> int:
        freq_map = collections.Counter(word)

        # Get frequencies and sort them in descending order
        frequencies = sorted(freq_map.values(), reverse=True)

        total_pushes = 0

        # Iterate through the sorted frequencies
        for i, freq in enumerate(frequencies):
            # The cost of typing a character depends on its position in the sorted list.
            # The first 9 distinct characters (indices 0-8) will be assigned to the first
            # positions on the 9 different buttons, costing 1 push each.
            # The next 9 distinct characters (indices 9-17) will be assigned to the second
            # positions on the 9 different buttons, costing 2 pushes each.
            # And so on.
            # The number of pushes for the character at index 'i' is (i // 9) + 1.

            pushes_per_char_type = (i // 9) + 1

            # Add the total pushes for this character type (frequency * pushes_per_char_type)
            total_pushes += freq * pushes_per_char_type

        return total_pushes