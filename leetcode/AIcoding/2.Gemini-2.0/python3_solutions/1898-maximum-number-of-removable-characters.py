class Solution:
    def maximumRemovals(self, s: str, p: str, removable: list[int]) -> int:
        def is_subsequence(s, p, removed):
            s_new = list(s)
            for i in removed:
                s_new[i] = ''
            s_new = ''.join(s_new)

            i = 0
            j = 0
            while i < len(s_new) and j < len(p):
                if s_new[i] == p[j]:
                    j += 1
                i += 1
            return j == len(p)

        l, r = 0, len(removable)
        ans = 0
        while l <= r:
            mid = (l + r) // 2

            if is_subsequence(s, p, removable[:mid]):
                ans = mid
                l = mid + 1
            else:
                r = mid - 1
        return ans