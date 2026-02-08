def maxChocolates(chocolates: List[int], K: int) -> int:
    n = len(chocolates)
    if n == 0 or K == 0:
        return 0

    chocolates.sort(reverse=True)
    return sum(chocolates[i] for i in range(min(K, n)))