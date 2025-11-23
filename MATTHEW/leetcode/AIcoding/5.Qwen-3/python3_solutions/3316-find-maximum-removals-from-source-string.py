class Solution:
    def maxRemovals(self, source: str, target: str) -> int:
        from collections import Counter

        count_source = Counter(source)
        count_target = Counter(target)

        for char in count_target:
            if count_target[char] > count_source[char]:
                return 0

        i = 0
        j = 0
        result = 0

        while i < len(source) and j < len(target):
            if source[i] == target[j]:
                i += 1
                j += 1
                result += 1
            else:
                i += 1

        return result