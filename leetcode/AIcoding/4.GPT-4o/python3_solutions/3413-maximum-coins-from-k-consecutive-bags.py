class Solution:
    def maxCoins(self, bags: List[int], k: int) -> int:
        n = len(bags)
        if k > n:
            return 0
        bags.sort(reverse=True)
        return sum(bags[i] for i in range(k))