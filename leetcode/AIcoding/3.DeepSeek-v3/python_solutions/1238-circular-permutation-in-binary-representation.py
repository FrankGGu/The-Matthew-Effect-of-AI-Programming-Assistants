class Solution:
    def circularPermutation(self, n: int, start: int) -> List[int]:
        gray = [i ^ (i >> 1) for i in range(1 << n)]
        idx = gray.index(start)
        return gray[idx:] + gray[:idx]