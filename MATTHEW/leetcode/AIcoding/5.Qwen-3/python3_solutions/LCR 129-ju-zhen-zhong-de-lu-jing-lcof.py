class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        if not board or not word:
            return False
        m, n = len(board), len(board[0])

        def dfs(i, j, k, visited):
            if k == len(word):
                return True
            if i < 0 or i >= m or j < 0 or j >= n or visited[i][j] or board[i][j] != word[k]:
                return False
            visited[i][j] = True
            res = dfs(i+1, j, k+1, visited) or dfs(i-1, j, k+1, visited) or dfs(i, j+1, k+1, visited) or dfs(i, j-1, k+1, visited)
            visited[i][j] = False
            return res

        for i in range(m):
            for j in range(n):
                visited = [[False]*n for _ in range(m)]
                if dfs(i, j, 0, visited):
                    return True
        return False