class Solution:
    def maximumRemovals(self, s: str, p: str, removable: list[int]) -> int:

        def is_subsequence(k_val: int) -> bool:
            removed_set = set()
            for i in range(k_val):
                removed_set.add(removable[i])

            p_ptr = 0
            s_ptr = 0

            while s_ptr < len(s) and p_ptr < len(p):
                if s_ptr in removed_set:
                    s_ptr += 1
                    continue

                if s[s_ptr] == p[p_ptr]:
                    p_ptr += 1
                s_ptr += 1

            return p_ptr == len(p)

        low = 0
        high = len(removable)
        ans = 0

        while low <= high:
            mid = low + (high - low) // 2
            if is_subsequence(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans