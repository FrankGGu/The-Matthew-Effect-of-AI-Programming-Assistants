class Solution:
    def is_palindrome(self, s: str) -> bool:
        return s == s[::-1]

    def palindromePairs(self, words: list[str]) -> list[list[int]]:
        word_map = {word: i for i, word in enumerate(words)}
        results = set()

        for i, word in enumerate(words):
            # Case 1: Word itself is a palindrome and an empty string exists
            # Example: words = ["aba", ""] -> ("aba" + "" or "" + "aba")
            if "" in word_map and self.is_palindrome(word) and word_map[""] != i:
                empty_idx = word_map[""]
                results.add((i, empty_idx))
                results.add((empty_idx, i))

            # Case 2: word + other_word is a palindrome where other_word is word's reverse
            # Example: words = ["abc", "cba"] -> ("abc" + "cba")
            word_rev = word[::-1]
            if word_rev in word_map and word_map[word_rev] != i:
                results.add((i, word_map[word_rev]))

            # Case 3: word can be split into prefix + suffix
            #   a) prefix is a palindrome, suffix_rev is other_word
            #      words[i] + words[j] = (prefix + suffix) + suffix_rev
            #      Example: words = ["abac", "cba"] -> ("abac" + "cba") where prefix="a", suffix="bac", other_word="cba"
            #   b) suffix is a palindrome, prefix_rev is other_word
            #      words[j] + words[i] = (prefix_rev) + (prefix + suffix)
            #      Example: words = ["cba", "abac"] -> ("cba" + "abac") where prefix="aba", suffix="c", other_word="cba"
            for k in range(1, len(word)): # k is the split point, 0 < k < len(word)
                left = word[:k]
                right = word[k:]

                # Check for case 3a: words[i] + words[j]
                if self.is_palindrome(left):
                    right_rev = right[::-1]
                    if right_rev in word_map and word_map[right_rev] != i:
                        results.add((i, word_map[right_rev]))

                # Check for case 3b: words[j] + words[i]
                if self.is_palindrome(right):
                    left_rev = left[::-1]
                    if left_rev in word_map and word_map[left_rev] != i:
                        results.add((word_map[left_rev], i))

        return list(map(list, results))