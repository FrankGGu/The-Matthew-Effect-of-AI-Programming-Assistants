def count_peaks(arr):
    n = len(arr)
    peaks = 0
    for i in range(1, n - 1):
        if arr[i] > arr[i - 1] and arr[i] > arr[i + 1]:
            peaks += 1
    return peaks