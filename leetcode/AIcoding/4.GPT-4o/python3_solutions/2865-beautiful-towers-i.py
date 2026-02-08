def beautifulTowers(A):
    n = len(A)
    A.sort()
    min_height = A[n // 2 - 1] if n % 2 == 0 else A[n // 2]
    return sum(abs(a - min_height) for a in A)