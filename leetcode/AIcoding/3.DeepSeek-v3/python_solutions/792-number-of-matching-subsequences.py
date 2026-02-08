class Solution:
    def numMatchingSubseq(self, s: str, words: List[str]) -> int:
        from collections import defaultdict
        word_dict = defaultdict(list)
        count = 0

        for word in words:
            word_dict[word[0]].append(word[1:])

        for char in s:
            words_starting_with_char = word_dict[char]
            del word_dict[char]
            for word in words_starting_with_char:
                if not word:
                    count += 1
                else:
                    word_dict[word[0]].append(word[1:])

        return count