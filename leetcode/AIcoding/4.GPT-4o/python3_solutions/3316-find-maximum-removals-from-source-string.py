class Solution:
    def maximumRemovals(self, s: str, p: str, removable: List[int]) -> int:
        def can_form_with_removals(mid):
            removed = set(removable[:mid])
            j = 0
            for i in range(len(s)):
                if i in removed:
                    continue
                if j < len(p) and s[i] == p[j]:
                    j += 1
            return j == len(p)

        left, right = 0, len(removable)
        while left < right:
            mid = (left + right + 1) // 2
            if can_form_with_removals(mid):
                left = mid
            else:
                right = mid - 1
        return left