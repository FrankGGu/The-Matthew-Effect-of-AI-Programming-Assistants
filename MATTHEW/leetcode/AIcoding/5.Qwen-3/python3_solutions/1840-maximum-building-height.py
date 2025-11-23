from typing import List

class Solution:
    def maxBuilding(self, n: int, k: int, arr: List[int]) -> int:
        arr.append((n, 0))
        arr.sort()
        res = 0
        for i in range(1, len(arr)):
            if arr[i][1] > arr[i - 1][1]:
                diff = arr[i][0] - arr[i - 1][0]
                h = arr[i - 1][1] + diff
                res = max(res, h)
            else:
                diff = arr[i][0] - arr[i - 1][0]
                h = arr[i - 1][1] + diff
                res = max(res, h)
        return res