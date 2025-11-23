class Solution:
    def oddString(self, words: List[str]) -> str:
        def get_diff(word):
            return tuple(ord(word[i+1]) - ord(word[i]) for i in range(len(word)-1))

        diff_counts = {}
        diffs = []

        for word in words:
            diff = get_diff(word)
            diffs.append(diff)
            if diff in diff_counts:
                diff_counts[diff] += 1
            else:
                diff_counts[diff] = 1

        for i, diff in enumerate(diffs):
            if diff_counts[diff] == 1:
                return words[i]

        return ""