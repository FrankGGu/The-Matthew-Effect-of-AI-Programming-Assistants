def maxCount(banned, n, maxSum):
    banned_set = set(banned)
    count = 0
    current_sum = 0

    for i in range(1, n + 1):
        if i not in banned_set and current_sum + i <= maxSum:
            current_sum += i
            count += 1

    return count