def captureForts(forts: list[int]) -> int:
    n = len(forts)
    max_length = 0
    last_one = -1
    last_neg_one = -1

    for i in range(n):
        if forts[i] == 1:
            if last_neg_one != -1:
                max_length = max(max_length, i - last_neg_one - 1)
            last_one = i
        elif forts[i] == -1:
            if last_one != -1:
                max_length = max(max_length, i - last_one - 1)
            last_neg_one = i

    return max_length