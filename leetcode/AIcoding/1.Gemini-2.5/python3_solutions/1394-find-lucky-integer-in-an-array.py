import collections

class Solution:
    def findLucky(self, arr: list[int]) -> int:
        freq_map = collections.Counter(arr)

        max_lucky = -1

        for num, freq in freq_map.items():
            if num == freq:
                max_lucky = max(max_lucky, num)

        return max_lucky