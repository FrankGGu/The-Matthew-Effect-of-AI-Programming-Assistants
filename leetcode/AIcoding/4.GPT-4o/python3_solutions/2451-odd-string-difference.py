class Solution:
    def oddString(self, words: List[str]) -> str:
        def get_diff(word):
            return tuple(ord(word[i + 1]) - ord(word[i]) for i in range(len(word) - 1))

        diffs = {}
        for word in words:
            diff = get_diff(word)
            if diff in diffs:
                diffs[diff].append(word)
            else:
                diffs[diff] = [word]

        for diff, lst in diffs.items():
            if len(lst) == 1:
                return lst[0]