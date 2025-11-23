import collections

class Solution:
    def oddString(self, words: list[str]) -> str:
        diff_map = collections.defaultdict(list)

        for word in words:
            diff_array = []
            for i in range(1, len(word)):
                diff_array.append(ord(word[i]) - ord(word[i-1]))

            diff_tuple = tuple(diff_array)
            diff_map[diff_tuple].append(word)

        for diff_list in diff_map.values():
            if len(diff_list) == 1:
                return diff_list[0]