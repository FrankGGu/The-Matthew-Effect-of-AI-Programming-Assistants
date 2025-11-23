class Solution:
    def minGroups(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        sorted_counts = sorted(count.values())

        def can_assign(k):
            total = 0
            for c in sorted_counts:
                if c < k:
                    return False
                total += (c + k - 1) // k
            return total

        left, right = 1, max(sorted_counts)
        answer = right

        while left <= right:
            mid = (left + right) // 2
            if can_assign(mid):
                answer = mid
                right = mid - 1
            else:
                left = mid + 1

        return can_assign(answer)