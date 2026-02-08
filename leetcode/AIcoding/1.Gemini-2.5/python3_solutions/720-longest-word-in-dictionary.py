class Solution:
    def longestWord(self, words: List[str]) -> str:
        words.sort(key=lambda x: (len(x), x))

        valid_words = set()
        longest_word = ""

        for word in words:
            if len(word) == 1 or word[:-1] in valid_words:
                valid_words.add(word)

                if len(word) > len(longest_word):
                    longest_word = word
                elif len(word) == len(longest_word):
                    # If lengths are equal, choose lexicographically smaller.
                    # Since words are sorted by length and then lexicographically,
                    # if we encounter a word 'w' that is valid and has the same length
                    # as 'longest_word', then 'w' must be lexicographically greater
                    # than or equal to the current 'longest_word'.
                    # We only update if 'w' is strictly lexicographically smaller,
                    # which would not happen given the sort order.
                    # So, the current 'longest_word' is already the lexicographically
                    # smallest among valid words of its length encountered so far.
                    pass

        return longest_word