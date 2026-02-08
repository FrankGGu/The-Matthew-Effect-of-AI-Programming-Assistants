class Solution:
    def maximumRemovals(self, s: str, p: str, removable: list[int]) -> int:
        def is_subsequence(t: str, sub: str) -> bool:
            i, j = 0, 0
            while i < len(t) and j < len(sub):
                if t[i] == sub[j]:
                    j += 1
                i += 1
            return j == len(sub)

        l, r = 0, len(removable)
        ans = 0
        while l <= r:
            mid = (l + r) // 2
            temp = list(s)
            for i in range(mid):
                temp[removable[i]] = ""

            if is_subsequence("".join(temp), p):
                ans = mid
                l = mid + 1
            else:
                r = mid - 1
        return ans