def check(array):
    count = 0
    n = len(array)
    for i in range(n):
        if array[i] > array[(i + 1) % n]:
            count += 1
    return count <= 1