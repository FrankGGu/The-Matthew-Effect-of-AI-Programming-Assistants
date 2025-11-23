class Solution:
    def rotateTheBox(self, box: List[List[str]]) -> List[List[str]]:
        m = len(box)
        n = len(box[0])
        rotated_box = [[''] * m for _ in range(n)]

        for i in range(m):
            stone_count = 0
            for j in range(n - 1, -1, -1):
                if box[i][j] == '#':
                    stone_count += 1
                    box[i][j] = '.'
                elif box[i][j] == '*':
                    for k in range(n - 1, j, -1):
                        if stone_count > 0:
                            box[i][k] = '#'
                            stone_count -= 1
                        else:
                            box[i][k] = '.'

            for k in range(n - 1, -1, -1):
                if stone_count > 0 and box[i][k] == '.':
                    box[i][k] = '#'
                    stone_count -= 1

        for i in range(m):
            for j in range(n):
                rotated_box[j][m - 1 - i] = box[i][j]

        return rotated_box