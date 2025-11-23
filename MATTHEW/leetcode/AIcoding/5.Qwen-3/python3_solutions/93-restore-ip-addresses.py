class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        result = []
        n = len(s)

        def backtrack(start, parts):
            if len(parts) == 4:
                if start == n:
                    result.append('.'.join(parts))
                return
            for i in range(start + 1, min(start + 4, n + 1)):
                segment = s[start:i]
                if (len(segment) > 1 and segment[0] == '0') or int(segment) > 255:
                    continue
                backtrack(i, parts + [segment])

        backtrack(0, [])
        return result