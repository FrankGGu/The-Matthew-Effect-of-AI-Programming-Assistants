class Solution:
    def getStrongest(self, arr: List[int], k: int) -> List[int]:
        arr.sort()
        n = len(arr)
        m = arr[(n - 1) // 2]
        arr.sort(key=lambda x: (-abs(x - m), -x))
        return arr[:k]