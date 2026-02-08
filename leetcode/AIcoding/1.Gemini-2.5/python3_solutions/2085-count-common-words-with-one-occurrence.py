import collections

class Solution:
    def countWords(self, words1: list[str], words2: list[str]) -> int:
        counts1 = collections.Counter(words1)
        counts2 = collections.Counter(words2)

        common_one_occurrence_count = 0

        for word, count in counts1.items():
            if count == 1:
                if word in counts2 and counts2[word] == 1:
                    common_one_occurrence_count += 1

        return common_one_occurrence_count