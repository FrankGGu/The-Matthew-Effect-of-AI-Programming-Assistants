import collections

class Solution:
    def kthDistinct(self, arr: list[str], k: int) -> str:
        counts = collections.Counter(arr)

        for s in arr:
            if counts[s] == 1:
                k -= 1
                if k == 0:
                    return s

        return ""