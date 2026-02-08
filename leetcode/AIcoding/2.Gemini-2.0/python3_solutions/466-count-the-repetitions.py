def getMaxRepetitions(s1: str, n1: int, s2: str, n2: int) -> int:
    if not s1 or not s2 or n1 == 0 or n2 == 0:
        return 0

    len1 = len(s1)
    len2 = len(s2)

    repeat_count = [0] * (len2 + 1)
    next_index = [0] * (len2 + 1)

    j = 0
    count = 0
    for k in range(1, len2 + 1):
        for i in range(len1):
            if s1[i] == s2[j]:
                j += 1
                if j == len2:
                    count += 1
                    j = 0
        repeat_count[k] = count
        next_index[k] = j

        for start in range(1, k):
            if next_index[start] == j:
                prefix_reps = repeat_count[start - 1]
                pattern_reps = (repeat_count[k] - repeat_count[start - 1]) * ((n1 - start) // (k - start))
                suffix_reps = repeat_count[start + (n1 - start) % (k - start)] - repeat_count[start - 1]
                return (prefix_reps + pattern_reps + suffix_reps) // n2

    return repeat_count[len2] * n1 // n2