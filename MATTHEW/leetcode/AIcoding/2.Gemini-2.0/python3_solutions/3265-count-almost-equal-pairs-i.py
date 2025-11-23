class Solution:
    def countAlmostEqualPairs(self, words: List[str]) -> int:
        n = len(words)
        count = 0
        for i in range(n):
            for j in range(i + 1, n):
                diff = 0
                for k in range(len(words[i])):
                    if words[i][k] != words[j][k]:
                        diff += 1
                if diff <= 2:
                    count += 1
        return count