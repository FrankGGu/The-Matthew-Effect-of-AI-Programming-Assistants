class Solution:
    def oddString(self, words: List[str]) -> str:
        diffs = []
        for word in words:
            diff = []
            for i in range(len(word) - 1):
                diff.append(ord(word[i+1]) - ord(word[i]))
            diffs.append(tuple(diff))

        counts = {}
        for i, diff in enumerate(diffs):
            if diff not in counts:
                counts[diff] = []
            counts[diff].append(i)

        for diff, indices in counts.items():
            if len(indices) == 1:
                return words[indices[0]]
        return ""