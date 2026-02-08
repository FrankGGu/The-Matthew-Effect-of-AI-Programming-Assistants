from collections import Counter

class Solution:
    def longestPalindrome(self, words: list[str]) -> int:
        counts = Counter(words)
        length = 0
        has_center_word = False

        for word in counts:
            if word[0] == word[1]:
                length += (counts[word] // 2) * 4
                if counts[word] % 2 == 1:
                    has_center_word = True
            else:
                rev_word = word[1] + word[0]
                if rev_word in counts and counts[word] > 0:
                    num_pairs = min(counts[word], counts[rev_word])
                    length += num_pairs * 4
                    counts[word] -= num_pairs
                    counts[rev_word] -= num_pairs

        if has_center_word:
            length += 2

        return length