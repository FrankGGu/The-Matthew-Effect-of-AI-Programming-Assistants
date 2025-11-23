def maxKItems(k: int, maxSum: int, numOnes: int, numZeros: int) -> int:
    ones = min(k, numOnes)
    remaining = k - ones
    zeros = min(remaining, numZeros)
    total_sum = ones + 0 * zeros
    if total_sum <= maxSum:
        return ones + zeros
    return (maxSum // 1) if maxSum < ones else ones