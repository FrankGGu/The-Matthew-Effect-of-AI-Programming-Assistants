from typing import List
from collections import defaultdict

class Solution:
    def countAlmostEquivalent(self, words: List[str]) -> int:
        def get_freq(word):
            freq = defaultdict(int)
            for c in word:
                freq[c] += 1
            return freq

        count = 0
        n = len(words)
        for i in range(n):
            freq_i = get_freq(words[i])
            for j in range(i + 1, n):
                freq_j = get_freq(words[j])
                diff = 0
                for c in freq_i:
                    if abs(freq_i[c] - freq_j.get(c, 0)) > 2:
                        diff += 1
                        break
                if diff == 0:
                    for c in freq_j:
                        if abs(freq_j[c] - freq_i.get(c, 0)) > 2:
                            diff += 1
                            break
                if diff == 0:
                    count += 1
        return count