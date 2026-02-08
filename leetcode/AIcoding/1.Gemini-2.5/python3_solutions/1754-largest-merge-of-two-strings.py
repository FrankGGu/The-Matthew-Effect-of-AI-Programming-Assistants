class Solution:
    def largestMerge(self, word1: str, word2: str) -> str:
        merge = []
        i, j = 0, 0
        n1, n2 = len(word1), len(word2)

        while i < n1 or j < n2:
            if i < n1 and j < n2:
                if word1[i:] > word2[j:]:
                    merge.append(word1[i])
                    i += 1
                else:
                    merge.append(word2[j])
                    j += 1
            elif i < n1:
                merge.append(word1[i])
                i += 1
            else:
                merge.append(word2[j])
                j += 1

        return "".join(merge)