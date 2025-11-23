class Solution:
    def minimumDistance(self, word: str) -> int:
        n = len(word)
        dp = {}

        def get_coord(char):
            if char == '#':
                return -1, -1
            idx = ord(char) - ord('A')
            return idx // 6, idx % 6

        def solve(i, left, right):
            if i == n:
                return 0
            if (i, left, right) in dp:
                return dp[(i, left, right)]

            char = word[i]
            left_dist = 0
            right_dist = 0

            lrow, lcol = get_coord(left)
            rrow, rcol = get_coord(right)
            crow, ccol = get_coord(char)

            if left != '#':
                left_dist = abs(lrow - crow) + abs(lcol - ccol)
            if right != '#':
                right_dist = abs(rrow - crow) + abs(rcol - ccol)

            ans = min(left_dist + solve(i + 1, char, right),
                      right_dist + solve(i + 1, left, char))

            dp[(i, left, right)] = ans
            return ans

        return solve(0, '#', '#')