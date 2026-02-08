class Solution:
    def maximumRemovals(self, s: str, p: str, removable: List[int]) -> int:
        left, right = 0, len(removable)
        def is_subsequence(k):
            remove = set(removable[:k])
            i = j = 0
            while i < len(s) and j < len(p):
                if i not in remove and s[i] == p[j]:
                    j += 1
                i += 1
            return j == len(p)

        while left < right:
            mid = (left + right + 1) // 2
            if is_subsequence(mid):
                left = mid
            else:
                right = mid - 1
        return left