from collections import Counter

class Solution:
    def kthDistinct(self, arr: list[str], k: int) -> str:
        counts = Counter(arr)
        distinct_strings = [s for s in arr if counts[s] == 1]
        if len(distinct_strings) < k:
            return ""
        else:
            return distinct_strings[k - 1]