def duplicateZeros(arr):
    n = len(arr)
    count = arr.count(0)
    i = n - 1

    while count > 0:
        if arr[i] == 0:
            if i + count < n:
                arr[i + count] = 0
            count -= 1
            if i + count < n:
                arr[i + count] = 0
        i -= 1