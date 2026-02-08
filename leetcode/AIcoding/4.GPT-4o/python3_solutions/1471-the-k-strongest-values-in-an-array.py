class Solution:
    def getStrongest(self, arr: List[int], k: int) -> List[int]:
        arr.sort()
        median = arr[(len(arr) - 1) // 2]
        strongest = sorted(arr, key=lambda x: (abs(x - median), x), reverse=True)
        return strongest[:k]