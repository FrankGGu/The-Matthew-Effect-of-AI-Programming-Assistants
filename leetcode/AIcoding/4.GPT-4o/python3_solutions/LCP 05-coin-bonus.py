def maxCoins(piles):
    piles.sort()
    n = len(piles) // 3
    return sum(piles[i] for i in range(n, 2 * n))