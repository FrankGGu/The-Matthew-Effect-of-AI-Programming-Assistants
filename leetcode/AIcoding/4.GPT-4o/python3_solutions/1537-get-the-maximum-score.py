def maxScore(cardPoints: List[int], k: int) -> int:
    n = len(cardPoints)
    total = sum(cardPoints)
    if k == n:
        return total

    min_subarray = float('inf')
    current_sum = 0

    for i in range(n - k):
        current_sum += cardPoints[i]

    min_subarray = min(min_subarray, current_sum)

    for i in range(n - k, n):
        current_sum += cardPoints[i] - cardPoints[i - (n - k)]
        min_subarray = min(min_subarray, current_sum)

    return total - min_subarray