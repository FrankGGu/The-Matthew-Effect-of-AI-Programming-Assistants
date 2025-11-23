class Solution:
    def getWordsInLongestSubsequence(self, n: int, words: List[str], groups: List[int]) -> List[str]:
        result = []
        current_group = -1
        for i in range(n):
            if groups[i] != current_group:
                result.append(words[i])
                current_group = groups[i]
        return result