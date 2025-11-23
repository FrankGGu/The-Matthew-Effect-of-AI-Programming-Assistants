class Solution:
    def longestCommonPrefix(self, strs: List[str], k: int) -> str:
        if not strs:
            return ""
        min_len = min(len(s) for s in strs)
        low, high = 1, min_len
        res = 0

        def is_possible(l):
            prefixes = set()
            for s in strs:
                prefix = s[:l]
                prefixes.add(prefix)
                if len(prefixes) > 1:
                    break
            if len(prefixes) <= 1:
                return True
            count = 0
            for s in strs:
                found = False
                for i in range(len(s) - l + 1):
                    if s[i:i+l] in prefixes:
                        found = True
                        break
                if not found:
                    count += 1
                    if count > k:
                        return False
            return count <= k

        while low <= high:
            mid = (low + high) // 2
            if is_possible(mid):
                res = mid
                low = mid + 1
            else:
                high = mid - 1
        return strs[0][:res] if res != 0 else ""