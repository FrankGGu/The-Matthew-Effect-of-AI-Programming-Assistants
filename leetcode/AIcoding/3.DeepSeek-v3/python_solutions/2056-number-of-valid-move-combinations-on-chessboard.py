class Solution:
    def countCombinations(self, pieces: List[str], positions: List[List[int]]) -> int:
        directions = {
            "rook": [(0, 1), (1, 0), (0, -1), (-1, 0)],
            "bishop": [(1, 1), (1, -1), (-1, 1), (-1, -1)],
            "queen": [(0, 1), (1, 0), (0, -1), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]
        }

        n = len(pieces)
        self.res = 0

        def dfs(pos, moves, step):
            if step == 0:
                self.res += 1
                return
            new_pos = []
            for i in range(n):
                x, y = pos[i]
                dx, dy = moves[i]
                nx, ny = x + dx, y + dy
                if 1 <= nx <= 8 and 1 <= ny <= 8:
                    new_pos.append((nx, ny))
                else:
                    new_pos.append((x, y))
            for mask in range(1 << n):
                next_pos = []
                valid = True
                for i in range(n):
                    if mask & (1 << i):
                        next_pos.append(new_pos[i])
                    else:
                        next_pos.append(pos[i])
                for i in range(n):
                    for j in range(i + 1, n):
                        if next_pos[i] == next_pos[j]:
                            valid = False
                            break
                    if not valid:
                        break
                if valid:
                    dfs(next_pos, moves, step - 1)

        def backtrack(pos, idx, moves):
            if idx == n:
                dfs(pos, moves, 7)
                return
            piece = pieces[idx]
            for dx, dy in directions[piece]:
                backtrack(pos, idx + 1, moves + [(dx, dy)])
            backtrack(pos, idx + 1, moves + [(0, 0)])

        start_pos = [(x, y) for x, y in positions]
        backtrack(start_pos, 0, [])
        return self.res