class Solution:
    def getStrongest(self, arr: List[int], k: int) -> List[int]:
        arr.sort()
        m = arr[(len(arr) - 1) // 2]
        arr.sort(key=lambda x: abs(x - m), reverse=True)
        return arr[:k]