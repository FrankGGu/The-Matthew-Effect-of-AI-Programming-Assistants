class Solution:
    def rotateTheBox(self, box: List[List[str]]) -> List[List[str]]:
        m, n = len(box), len(box[0])
        for i in range(m):
            j = n - 1
            for k in range(n - 1, -1, -1):
                if box[i][k] == '*':
                    j = k - 1
                elif box[i][k] == '#':
                    box[i][k], box[i][j] = box[i][j], box[i][k]
                    j -= 1
        return [list(row) for row in zip(*box[::-1])]