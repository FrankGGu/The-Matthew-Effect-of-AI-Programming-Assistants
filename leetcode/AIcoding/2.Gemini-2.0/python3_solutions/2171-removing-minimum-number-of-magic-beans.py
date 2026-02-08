class Solution:
    def minimumRemoval(self, beans: List[int]) -> int:
        beans.sort()
        n = len(beans)
        total_sum = sum(beans)
        ans = float('inf')
        for i in range(n):
            ans = min(ans, total_sum - beans[i] * (n - i))
        return int(ans)