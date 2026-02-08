class Solution:
    def longestDupSubstring(self, s: str) -> str:
        n = len(s)
        nums = [ord(c) - ord('a') for c in s]
        base = 26
        mod = 2**63 - 1

        left, right = 1, n
        res = ""
        while left <= right:
            mid = left + (right - left) // 2
            found = self.search(mid, base, mod, nums)
            if found != -1:
                res = s[found:found + mid]
                left = mid + 1
            else:
                right = mid - 1
        return res

    def search(self, L: int, base: int, mod: int, nums: List[int]) -> int:
        n = len(nums)
        h = 0
        for i in range(L):
            h = (h * base + nums[i]) % mod
        seen = {h}
        aL = pow(base, L, mod)
        for start in range(1, n - L + 1):
            h = (h * base - nums[start - 1] * aL + nums[start + L - 1]) % mod
            if h in seen:
                return start
            seen.add(h)
        return -1