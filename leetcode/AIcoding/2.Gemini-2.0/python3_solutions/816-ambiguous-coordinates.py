class Solution:
    def ambiguousCoordinates(self, s: str) -> list[str]:
        s = s[1:-1]

        def get_valid(s):
            res = []
            if len(s) == 1 or s[0] != '0':
                res.append(s)
            for i in range(1, len(s)):
                left = s[:i]
                right = s[i:]
                if len(left) > 1 and left[0] == '0':
                    continue
                if right[-1] == '0':
                    continue
                res.append(left + '.' + right)
            return res

        ans = []
        for i in range(1, len(s)):
            left = s[:i]
            right = s[i:]
            left_valid = get_valid(left)
            right_valid = get_valid(right)
            for l in left_valid:
                for r in right_valid:
                    ans.append('(' + l + ', ' + r + ')')
        return ans