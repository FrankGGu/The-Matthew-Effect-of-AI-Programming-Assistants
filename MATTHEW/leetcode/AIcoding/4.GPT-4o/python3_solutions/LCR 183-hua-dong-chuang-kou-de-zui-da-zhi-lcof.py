def highestPeakedMountain(A):
    n = len(A)
    for i in range(1, n - 1):
        if A[i] > A[i - 1] and A[i] > A[i + 1]:
            left = i
            while left > 0 and A[left - 1] < A[left]:
                left -= 1
            right = i
            while right < n - 1 and A[right + 1] < A[right]:
                right += 1
            if right - left + 1 > 2:
                return right - left + 1
    return 0