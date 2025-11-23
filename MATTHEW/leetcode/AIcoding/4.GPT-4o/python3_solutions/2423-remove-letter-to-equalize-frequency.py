class Solution:
    def equalFrequency(self, word: str) -> bool:
        from collections import Counter

        freq = Counter(word)
        freq_count = Counter(freq.values())

        if len(freq_count) == 1:
            return True

        if len(freq_count) == 2:
            keys = list(freq_count.keys())
            if (freq_count[keys[0]] == 1 and (keys[0] - 1 == 0 or keys[0] - 1 in freq_count)) or \
               (freq_count[keys[1]] == 1 and (keys[1] - 1 == 0 or keys[1] - 1 in freq_count)):
                return True

        return False