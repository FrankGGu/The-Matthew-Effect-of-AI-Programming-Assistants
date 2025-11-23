class Solution:
    def similarPairs(self, words: list[str]) -> int:
        count = 0
        for i in range(len(words)):
            for j in range(i + 1, len(words)):
                set1 = set(words[i])
                set2 = set(words[j])
                if set1 == set2:
                    count += 1
        return count