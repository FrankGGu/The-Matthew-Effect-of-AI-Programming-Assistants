import collections

class Solution:
    def numMatchingSubsequences(self, s: str, words: list[str]) -> int:
        # Create a dictionary where keys are characters 'a'-'z'
        # and values are lists of (word_index, current_char_index) tuples.
        # This allows us to group words by the character they are currently waiting for.
        waiting_words = collections.defaultdict(list)

        # Initialize waiting_words: each word starts by waiting for its first character.
        # Store (original_word_index, next_char_index_in_word)
        for i, word in enumerate(words):
            # Problem constraints state 1 <= words[i].length <= 50, so words are never empty.
            waiting_words[word[0]].append((i, 0))

        count = 0

        # Iterate through each character in s
        for char_s in s:
            # Get the list of words that are waiting for the current character `char_s`.
            # We need to process this list and then clear it for `char_s`
            # because these words will now be waiting for their *next* character.
            # Create a temporary list to avoid modifying the list while iterating it.
            current_char_list = waiting_words[char_s]
            waiting_words[char_s] = [] # Clear the list for char_s for the next iteration of s

            # For each word in `current_char_list`:
            for word_idx, char_idx in current_char_list:
                # Move to the next character in the word
                char_idx += 1

                # If we have processed all characters of the word, it's a matching subsequence.
                if char_idx == len(words[word_idx]):
                    count += 1
                else:
                    # Otherwise, the word is now waiting for its next character.
                    # Add it to the appropriate list in `waiting_words`.
                    waiting_words[words[word_idx][char_idx]].append((word_idx, char_idx))

        return count