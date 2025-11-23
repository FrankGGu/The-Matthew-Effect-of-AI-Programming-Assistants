def intersection(arrays):
    from collections import Counter
    count = Counter()

    for array in arrays:
        for num in set(array):
            count[num] += 1

    return [num for num in count if count[num] == len(arrays)]