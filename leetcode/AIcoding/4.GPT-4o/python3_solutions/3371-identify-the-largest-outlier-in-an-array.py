def largestOutlier(arr):
    if len(arr) < 3:
        return None

    arr.sort()
    return arr[-1] if arr[-1] - arr[-2] > arr[1] - arr[0] else arr[0]