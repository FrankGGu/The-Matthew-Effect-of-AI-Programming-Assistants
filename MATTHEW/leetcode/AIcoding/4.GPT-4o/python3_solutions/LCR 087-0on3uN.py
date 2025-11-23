class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        def backtrack(start=0, path=[]):
            if len(path) == 4:
                if start == len(s):
                    result.append(".".join(path))
                return
            for length in range(1, 4):
                if start + length <= len(s):
                    part = s[start:start + length]
                    if (length == 1) or (part[0] != '0' and int(part) <= 255):
                        backtrack(start + length, path + [part])

        result = []
        backtrack()
        return result