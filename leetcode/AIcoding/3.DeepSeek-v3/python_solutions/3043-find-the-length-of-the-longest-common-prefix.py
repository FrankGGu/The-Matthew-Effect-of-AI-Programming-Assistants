class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> int:
        if not strs:
            return 0
        min_len = min(len(s) for s in strs)
        low, high = 1, min_len
        max_len = 0

        def isCommonPrefix(length):
            prefix = strs[0][:length]
            for s in strs:
                if not s.startswith(prefix):
                    return False
            return True

        while low <= high:
            mid = (low + high) // 2
            if isCommonPrefix(mid):
                max_len = mid
                low = mid + 1
            else:
                high = mid - 1
        return max_len