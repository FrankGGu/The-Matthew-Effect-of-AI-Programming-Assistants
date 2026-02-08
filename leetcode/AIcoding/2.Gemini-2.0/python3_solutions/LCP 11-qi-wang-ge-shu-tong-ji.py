def expected_counts(arr):
    counts = {}
    for num in arr:
        counts[num] = counts.get(num, 0) + 1

    expected_count = 0
    for count in counts.values():
        expected_count += min(count, 2)

    return expected_count