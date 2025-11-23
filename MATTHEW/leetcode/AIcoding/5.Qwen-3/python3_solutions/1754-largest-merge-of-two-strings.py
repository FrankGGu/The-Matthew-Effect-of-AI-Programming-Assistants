class Solution:
    def largestMerge(self, s1: str, s2: str) -> str:
        merge = []
        i = j = 0
        while i < len(s1) and j < len(s2):
            if s1[i:] > s2[j:]:
                merge.append(s1[i])
                i += 1
            else:
                merge.append(s2[j])
                j += 1
        merge.extend(s1[i:])
        merge.extend(s2[j:])
        return ''.join(merge)