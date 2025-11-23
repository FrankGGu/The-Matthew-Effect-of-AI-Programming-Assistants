class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        def backtrack(start, parts):
            if len(parts) == 4:
                if start == len(s):
                    res.append(".".join(parts))
                return
            for i in range(1, 4):
                if start + i > len(s):
                    break
                segment = s[start:start+i]
                if (segment[0] == '0' and len(segment) > 1) or (i == 3 and int(segment) > 255):
                    continue
                parts.append(segment)
                backtrack(start + i, parts)
                parts.pop()

        res = []
        backtrack(0, [])
        return res