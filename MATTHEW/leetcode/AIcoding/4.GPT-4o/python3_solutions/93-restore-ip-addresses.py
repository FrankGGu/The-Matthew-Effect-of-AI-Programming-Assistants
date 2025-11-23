class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        def backtrack(start: int, path: List[str]):
            if len(path) == 4 and start == len(s):
                result.append('.'.join(path))
                return
            if len(path) >= 4:
                return

            for length in range(1, 4):
                if start + length > len(s):
                    break
                segment = s[start:start + length]
                if (length > 1 and segment[0] == '0') or int(segment) > 255:
                    continue
                backtrack(start + length, path + [segment])

        result = []
        backtrack(0, [])
        return result