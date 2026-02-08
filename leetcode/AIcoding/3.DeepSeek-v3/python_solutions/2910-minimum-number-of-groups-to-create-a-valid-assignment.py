class Solution:
    def minGroupsForValidAssignment(self, nums: List[int]) -> int:
        from collections import Counter

        freq = Counter(nums)
        counts = list(freq.values())
        min_count = min(counts)

        for k in range(min_count, 0, -1):
            total = 0
            for c in counts:
                q, r = divmod(c, k)
                if r > q:
                    break
                total += q + (1 if r > 0 else 0)
            else:
                return total

        return len(counts)