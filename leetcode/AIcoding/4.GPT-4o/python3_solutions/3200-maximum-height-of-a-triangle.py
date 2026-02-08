def maxHeight(self, A: List[int]) -> int:
    A.sort(reverse=True)
    return sum(A[:3])