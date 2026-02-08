from typing import List

class Solution:
    def stringMatching(self, words: List[str]) -> List[str]:
        result = set()
        n = len(words)
        for i in range(n):
            for j in range(n):
                if i == j:
                    continue
                if words[i] in words[j]:
                    result.add(words[i])
        return list(result)