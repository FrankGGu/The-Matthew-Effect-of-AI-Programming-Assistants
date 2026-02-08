def oddEvenJumps(A):
    n = len(A)
    if n == 1:
        return 1
    odd = [False] * n
    even = [False] * n
    odd[-1] = even[-1] = True

    next_higher = [None] * n
    next_lower = [None] * n

    stack = []
    for i in range(n):
        while stack and A[stack[-1]] < A[i]:
            next_higher[stack.pop()] = i
        stack.append(i)

    stack = []
    for i in range(n):
        while stack and A[stack[-1]] > A[i]:
            next_lower[stack.pop()] = i
        stack.append(i)

    for i in range(n - 2, -1, -1):
        if next_higher[i] is not None:
            odd[i] = even[next_higher[i]]
        if next_lower[i] is not None:
            even[i] = odd[next_lower[i]]

    return sum(odd) + sum(even)