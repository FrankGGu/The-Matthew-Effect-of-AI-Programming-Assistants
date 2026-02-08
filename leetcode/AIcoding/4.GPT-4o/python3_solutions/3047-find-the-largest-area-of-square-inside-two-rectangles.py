def maxSquareArea(A: List[int], B: List[int]) -> int:
    A.sort()
    B.sort()
    max_side = min(A[-1], B[-1])
    return max_side * max_side