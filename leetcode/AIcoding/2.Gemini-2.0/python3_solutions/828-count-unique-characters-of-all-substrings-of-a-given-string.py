class Solution:
    def uniqueLetterString(self, s: str) -> int:
        index = {}
        for i, c in enumerate(s):
            if c not in index:
                index[c] = [-1, -1]
            else:
                index[c][0] = index[c][1]
            index[c][1] = i

        ans = 0
        for c in index:
            first = index[c][0]
            second = index[c][1]
            ans += (second - first) * (len(s) - second)

        return ans