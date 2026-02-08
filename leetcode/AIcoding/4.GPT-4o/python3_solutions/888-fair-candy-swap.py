def fairCandySwap(A, B):
    sumA, sumB = sum(A), sum(B)
    setB = set(B)
    delta = (sumA - sumB) // 2
    for x in A:
        if x - delta in setB:
            return [x, x - delta]