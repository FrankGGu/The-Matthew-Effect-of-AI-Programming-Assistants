class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        def backtrack(start, parts, current):
            if start == len(s) and len(parts) == 4:
                result.append('.'.join(parts))
                return
            if len(parts) >= 4:
                return
            for end in range(start + 1, min(start + 4, len(s) + 1)):
                segment = s[start:end]
                if len(segment) > 1 and segment[0] == '0':
                    continue
                if 0 <= int(segment) <= 255:
                    backtrack(end, parts + [segment], current + segment + '.')

        result = []
        backtrack(0, [], "")
        return result