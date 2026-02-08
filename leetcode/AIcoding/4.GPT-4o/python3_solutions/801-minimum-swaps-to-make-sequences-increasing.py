def minSwap(A: List[int], B: List[int]) -> int:
    n = len(A)
    no_swap = [0] * n
    swap = [0] * n

    for i in range(1, n):
        no_swap[i] = swap[i] = float('inf')
        if A[i] > A[i - 1] and B[i] > B[i - 1]:
            no_swap[i] = no_swap[i - 1]
            swap[i] = swap[i - 1] + 1
        if A[i] > B[i - 1] and B[i] > A[i - 1]:
            no_swap[i] = min(no_swap[i], swap[i - 1])
            swap[i] = min(swap[i], no_swap[i - 1] + 1)

    return min(no_swap[-1], swap[-1])