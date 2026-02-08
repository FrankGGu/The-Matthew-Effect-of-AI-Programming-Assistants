def max_sales(sales, k):
    if not sales or len(sales) < k:
        return 0

    window_sum = sum(sales[:k])
    max_sum = window_sum

    for i in range(k, len(sales)):
        window_sum += sales[i] - sales[i - k]
        max_sum = max(max_sum, window_sum)

    return max_sum