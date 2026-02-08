class Solution:
    def findValidPairs(self, s: str) -> List[List[int]]:
        result = []
        for i in range(len(s) - 1):
            first = int(s[i])
            second = int(s[i+1])
            if (first + second) % 2 == 1:
                result.append([i, i+1])
        return result