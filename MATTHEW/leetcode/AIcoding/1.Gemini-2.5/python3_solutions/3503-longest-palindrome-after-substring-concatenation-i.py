from collections import Counter

class Solution:
    def longestPalindrome(self, words: list[str]) -> int:
        counts = Counter(words)
        total_length = 0
        has_center_word = False

        for word in counts:
            if counts[word] == 0:
                continue

            rev_word = word[1] + word[0]

            if word == rev_word:  # Palindrome word (e.g., "aa")
                total_length += (counts[word] // 2) * 4
                if counts[word] % 2 == 1:
                    has_center_word = True
                counts[word] = 0  # Mark as used

            elif rev_word in counts and counts[rev_word] > 0:  # Non-palindrome word (e.g., "ab") and its reverse ("ba")
                num_pairs = min(counts[word], counts[rev_word])
                total_length += num_pairs * 4
                counts[word] -= num_pairs
                counts[rev_word] -= num_pairs

        if has_center_word:
            total_length += 2  # Add 2 for the single center word (e.g., "gg")

        return total_length