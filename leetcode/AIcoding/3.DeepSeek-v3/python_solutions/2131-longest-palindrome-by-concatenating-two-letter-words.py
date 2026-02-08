from collections import defaultdict

class Solution:
    def longestPalindrome(self, words: List[str]) -> int:
        freq = defaultdict(int)
        for word in words:
            freq[word] += 1

        res = 0
        central = False

        for word in freq:
            if word[0] == word[1]:
                count = freq[word]
                if count % 2 == 0:
                    res += count
                else:
                    res += count - 1
                    central = True
            else:
                reversed_word = word[::-1]
                if reversed_word in freq:
                    res += min(freq[word], freq[reversed_word])

        if central:
            res += 1

        return res * 2