from typing import List

class Solution:
    def prefixSuffixPair(self, words: List[str]) -> int:
        count = 0
        n = len(words)
        for i in range(n):
            for j in range(i + 1, n):
                if words[j].startswith(words[i]) and words[j].endswith(words[i]):
                    count += 1
        return count