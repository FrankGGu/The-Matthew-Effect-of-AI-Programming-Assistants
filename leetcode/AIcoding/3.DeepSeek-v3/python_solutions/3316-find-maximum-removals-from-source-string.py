class Solution:
    def maximumRemovals(self, s: str, p: str, removable: List[int]) -> int:
        def is_subsequence(mid):
            removed = set(removable[:mid+1])
            i = j = 0
            while i < len(s) and j < len(p):
                if i not in removed and s[i] == p[j]:
                    j += 1
                i += 1
            return j == len(p)

        left, right = 0, len(removable) - 1
        res = 0
        while left <= right:
            mid = (left + right) // 2
            if is_subsequence(mid):
                res = mid + 1
                left = mid + 1
            else:
                right = mid - 1
        return res