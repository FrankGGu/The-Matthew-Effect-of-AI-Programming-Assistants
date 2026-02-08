class Solution:
    def maxSum(self, perm: List[int], k: int) -> int:
        n = len(perm)
        perm.sort(reverse=True)
        max_sum = 0
        for i in range(k):
            if i < n:
                max_sum += perm[i]
        return max_sum