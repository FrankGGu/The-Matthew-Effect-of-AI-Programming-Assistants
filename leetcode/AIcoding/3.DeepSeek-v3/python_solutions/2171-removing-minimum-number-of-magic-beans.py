class Solution:
    def minimumRemoval(self, beans: List[int]) -> int:
        beans.sort()
        total = sum(beans)
        n = len(beans)
        min_removal = float('inf')

        for i in range(n):
            current = total - beans[i] * (n - i)
            if current < min_removal:
                min_removal = current

        return min_removal