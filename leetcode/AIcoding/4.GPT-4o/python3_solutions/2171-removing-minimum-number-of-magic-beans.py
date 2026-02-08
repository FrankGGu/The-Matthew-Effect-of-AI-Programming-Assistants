class Solution:
    def minBeans(self, beans: List[int]) -> int:
        total = sum(beans)
        n = len(beans)
        min_removal = float('inf')

        beans.sort()
        for i in range(n):
            removal = total - (n - i) * beans[i]
            min_removal = min(min_removal, removal)

        return min_removal