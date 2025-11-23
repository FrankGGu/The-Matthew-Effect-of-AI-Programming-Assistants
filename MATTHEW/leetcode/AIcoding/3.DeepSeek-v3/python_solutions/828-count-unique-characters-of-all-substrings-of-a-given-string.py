class Solution:
    def uniqueLetterString(self, s: str) -> int:
        from collections import defaultdict

        index_map = defaultdict(list)
        for idx, char in enumerate(s):
            index_map[char].append(idx)

        result = 0
        for char in index_map:
            indices = index_map[char]
            for i in range(len(indices)):
                left = indices[i] - (indices[i-1] if i > 0 else -1)
                right = (indices[i+1] if i < len(indices)-1 else len(s)) - indices[i]
                result += left * right

        return result