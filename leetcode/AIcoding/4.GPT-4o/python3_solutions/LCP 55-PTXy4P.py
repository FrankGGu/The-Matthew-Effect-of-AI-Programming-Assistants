def maxFruits(fruits, startPos, k):
    n = len(fruits)
    total = 0
    left = startPos - k
    right = startPos + k
    prefix_sum = [0] * (n + 1)

    for i in range(n):
        prefix_sum[i + 1] = prefix_sum[i] + fruits[i]

    for i in range(max(0, left), min(n, right + 1)):
        if i < left:
            continue
        j = min(n - 1, right + (left - i))
        total = max(total, prefix_sum[j + 1] - prefix_sum[i])

    return total