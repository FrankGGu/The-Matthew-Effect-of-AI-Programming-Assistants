class Solution:
    def maxCount(self, banned: List[int], n: int, maxSum: int) -> int:
        banned_set = set(banned)
        total = 0
        count = 0
        for num in range(1, n + 1):
            if num not in banned_set:
                if total + num <= maxSum:
                    total += num
                    count += 1
                else:
                    break
        return count