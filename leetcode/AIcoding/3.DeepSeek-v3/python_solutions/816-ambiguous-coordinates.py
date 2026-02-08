class Solution:
    def ambiguousCoordinates(self, s: str) -> List[str]:
        s = s[1:-1]
        n = len(s)
        res = []

        def make(frag):
            m = len(frag)
            for d in range(1, m+1):
                left = frag[:d]
                right = frag[d:]
                if (not left.startswith('0') or left == '0') and (not right.endswith('0')):
                    if right:
                        yield left + '.' + right
                    else:
                        yield left

        for i in range(1, n):
            left_part = s[:i]
            right_part = s[i:]
            left_options = list(make(left_part))
            right_options = list(make(right_part))
            for l in left_options:
                for r in right_options:
                    res.append(f"({l}, {r})")
        return res