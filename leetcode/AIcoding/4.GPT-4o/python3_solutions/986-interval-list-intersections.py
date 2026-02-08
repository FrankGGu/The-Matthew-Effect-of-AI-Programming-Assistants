def intervalIntersection(A, B):
    res = []
    i, j = 0, 0
    while i < len(A) and j < len(B):
        startA, endA = A[i]
        startB, endB = B[j]
        if endA < startB:
            i += 1
        elif endB < startA:
            j += 1
        else:
            res.append([max(startA, startB), min(endA, endB)])
            if endA < endB:
                i += 1
            else:
                j += 1
    return res