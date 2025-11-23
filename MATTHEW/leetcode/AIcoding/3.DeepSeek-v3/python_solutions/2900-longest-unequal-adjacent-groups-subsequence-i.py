class Solution:
    def getWordsInLongestSubsequence(self, n: int, words: List[str], groups: List[int]) -> List[str]:
        result = []
        for i in range(n):
            if i == 0 or groups[i] != groups[i - 1]:
                result.append(words[i])
        return result