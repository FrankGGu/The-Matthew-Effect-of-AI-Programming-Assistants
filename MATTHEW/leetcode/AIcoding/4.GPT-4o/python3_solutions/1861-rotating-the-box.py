class Solution:
    def rotateTheBox(self, box: List[List[str]]) -> List[List[str]]:
        n, m = len(box), len(box[0])
        result = [['' for _ in range(n)] for _ in range(m)]

        for j in range(m):
            empty = n - 1
            for i in range(n - 1, -1, -1):
                if box[i][j] == '#':
                    result[j][empty] = '#'
                    empty -= 1
                elif box[i][j] == '*':
                    empty = i - 1

            for i in range(empty, -1, -1):
                result[j][i] = '.'

        return result