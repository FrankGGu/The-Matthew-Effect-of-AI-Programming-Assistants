def findSequence(arr):
    n = len(arr)
    result = []

    for i in range(n):
        if arr[i] == "X":
            result.pop() if result else None
        else:
            result.append(arr[i])

    return result