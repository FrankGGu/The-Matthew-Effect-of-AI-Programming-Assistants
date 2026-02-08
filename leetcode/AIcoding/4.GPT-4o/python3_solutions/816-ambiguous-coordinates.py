class Solution:
    def ambiguousCoordinates(self, s: str) -> List[str]:
        s = s[1:-1]
        res = []
        n = len(s)

        for i in range(1, n):
            left = s[:i]
            right = s[i:]
            for l in self.get_coords(left):
                for r in self.get_coords(right):
                    res.append(f"({l}, {r})")
        return res

    def get_coords(self, s: str) -> List[str]:
        if s == "0":
            return ["0"]
        if s[0] == '0' and s[-1] == '0':
            return []
        if s[0] == '0':
            return [s[-1:]]
        if s[-1] == '0':
            return [s]

        coords = [s]
        for i in range(1, len(s)):
            coords.append(s[:i] + '.' + s[i:])
        return coords