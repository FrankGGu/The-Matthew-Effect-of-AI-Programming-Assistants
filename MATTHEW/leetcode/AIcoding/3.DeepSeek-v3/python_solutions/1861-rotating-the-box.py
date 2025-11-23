class Solution:
    def rotateTheBox(self, box: List[List[str]]) -> List[List[str]]:
        m, n = len(box), len(box[0])

        for row in box:
            pos = n - 1
            for j in range(n - 1, -1, -1):
                if row[j] == '*':
                    pos = j - 1
                elif row[j] == '#':
                    row[j] = '.'
                    row[pos] = '#'
                    pos -= 1

        rotated = [[None for _ in range(m)] for _ in range(n)]
        for i in range(m):
            for j in range(n):
                rotated[j][m - 1 - i] = box[i][j]

        return rotated