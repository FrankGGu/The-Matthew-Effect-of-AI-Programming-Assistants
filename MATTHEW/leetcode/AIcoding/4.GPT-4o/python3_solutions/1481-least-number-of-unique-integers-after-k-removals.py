from collections import Counter

def findLeastNumOfUniqueInts(arr, k):
    count = Counter(arr)
    unique_counts = sorted(count.values())

    for unique_count in unique_counts:
        if k >= unique_count:
            k -= unique_count
        else:
            break

    return len(unique_counts) - (unique_counts.index(unique_count) + 1)