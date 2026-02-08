import collections

class Solution:
    def getStrongest(self, arr: list[int], k: int) -> list[int]:
        n = len(arr)
        arr.sort()

        median = arr[(n - 1) // 2]

        # Sort based on strength and then value
        # Custom sort key:
        # 1. abs(x - median) in descending order
        # 2. x in descending order
        arr.sort(key=lambda x: (abs(x - median), x), reverse=True)

        return arr[:k]