import collections

class Solution:
    def longestPalindrome(self, words: list[str]) -> int:
        counts = collections.Counter(words)

        length = 0
        has_center_palindrome = False

        for word in counts:
            if counts[word] == 0:
                continue

            rev_word = word[1] + word[0]

            if word == rev_word: # Palindrome word, e.g., "gg"
                # Each pair of such words forms "gggg" (length 4)
                length += (counts[word] // 2) * 4
                # If there's an odd count, one can be used in the very center
                if counts[word] % 2 == 1:
                    has_center_palindrome = True
                counts[word] = 0 # Mark as used
            else: # Non-palindrome word, e.g., "lc"
                if counts[rev_word] > 0:
                    # Form pairs like "lc" + "cl" = "lccl" (length 4)
                    pairs = min(counts[word], counts[rev_word])
                    length += pairs * 4
                    counts[word] -= pairs
                    counts[rev_word] -= pairs

        # If there's a single palindrome word left, it can be placed in the center
        if has_center_palindrome:
            length += 2

        return length