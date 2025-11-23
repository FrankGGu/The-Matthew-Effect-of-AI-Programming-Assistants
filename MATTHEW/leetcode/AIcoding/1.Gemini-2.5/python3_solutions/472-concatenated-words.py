import collections

class Solution:
    def findAllConcatenatedWordsInADict(self, words: List[str]) -> List[str]:
        # Sort words by length. This ensures that when we check a word,
        # all its potential components (which must be strictly shorter)
        # would have already been processed and added to the 'pre_words' set.
        words.sort(key=len)

        pre_words = set() # Stores words encountered so far
        result = []

        def can_be_concatenated(word: str, current_word_set: set) -> bool:
            n = len(word)
            if n == 0:
                return False

            # dp[i] stores the minimum number of words needed to form word[0...i-1]
            # Initialize with infinity, dp[0] = 0 (empty prefix needs 0 words)
            dp = [float('inf')] * (n + 1)
            dp[0] = 0

            for i in range(1, n + 1):
                for j in range(i):
                    # If word[0...j-1] can be formed (dp[j] is not inf)
                    # AND word[j...i-1] is a valid word in the current_word_set
                    if dp[j] != float('inf') and word[j:i] in current_word_set:
                        # Update dp[i] with the minimum number of words
                        dp[i] = min(dp[i], dp[j] + 1)

            # A word is concatenated if it can be formed by 2 or more words.
            # Since 'current_word_set' only contains words processed *before* the current 'word'
            # (due to sorting by length), and the current 'word' itself is NOT in 'current_word_set'
            # when this function is called, any 'word[j:i]' found in 'current_word_set'
            # must be a strictly shorter word.
            # Thus, dp[n] >= 2 correctly identifies concatenated words.
            return dp[n] >= 2

        for word in words:
            # If pre_words is empty, it means we are processing the shortest words.
            # These cannot be formed by other words, so just add them to pre_words and continue.
            if not pre_words:
                pre_words.add(word)
                continue

            if can_be_concatenated(word, pre_words):
                result.append(word)

            # Add the current word to pre_words for future checks.
            pre_words.add(word)

        return result