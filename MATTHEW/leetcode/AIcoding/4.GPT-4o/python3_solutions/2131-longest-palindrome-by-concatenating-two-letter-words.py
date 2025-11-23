class Solution:
    def longestPalindrome(self, words: List[str]) -> int:
        from collections import Counter

        count = Counter(words)
        length = 0
        odd_found = False

        for word, cnt in count.items():
            if word[0] == word[1]:
                length += (cnt // 2) * 4
                if cnt % 2 == 1:
                    odd_found = True
            else:
                reverse_word = word[::-1]
                if reverse_word in count:
                    length += min(cnt, count[reverse_word]) * 4

        if odd_found:
            length += 2

        return length