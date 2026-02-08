from collections import defaultdict

class Solution:
    def numMatchingSubseq(self, s: str, words: list[str]) -> int:
        word_dict = defaultdict(list)
        for word in words:
            word_dict[word[0]].append(word)

        count = 0
        for char in s:
            words_to_process = word_dict[char]
            word_dict[char] = []

            for word in words_to_process:
                if len(word) == 1:
                    count += 1
                else:
                    word_dict[word[1]].append(word[1:])

        return count