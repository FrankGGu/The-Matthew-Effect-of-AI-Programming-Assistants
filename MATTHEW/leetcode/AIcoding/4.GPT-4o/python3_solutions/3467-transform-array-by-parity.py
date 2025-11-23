def transformArray(arr):
    n = len(arr)
    result = arr[:]
    for i in range(1, n - 1):
        if arr[i] % 2 == 0 and arr[i - 1] % 2 == 1 and arr[i + 1] % 2 == 1:
            result[i] -= 1
        elif arr[i] % 2 == 1 and arr[i - 1] % 2 == 0 and arr[i + 1] % 2 == 0:
            result[i] += 1
    return result