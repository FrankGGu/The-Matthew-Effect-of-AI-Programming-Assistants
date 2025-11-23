class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        result = []
        n = len(s)

        def backtrack(start, parts):
            if start == n and len(parts) == 4:
                result.append('.'.join(parts))
                return
            if len(parts) >= 4:
                return
            for i in range(start + 1, min(start + 4, n + 1)):
                part = s[start:i]
                if (len(part) > 1 and part[0] == '0') or int(part) > 255:
                    continue
                backtrack(i, parts + [part])

        backtrack(0, [])
        return result