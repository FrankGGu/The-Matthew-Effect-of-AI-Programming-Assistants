import collections

class Solution:
    def solve(self, grid: list[str]) -> int:
        R, C = len(grid), len(grid[0])

        start_r, start_c = -1, -1
        end_r, end_c = -1, -1
        all_T_cells = []

        for r in range(R):
            for c in range(C):
                if grid[r][c] == 'S':
                    start_r, start_c = r, c
                elif grid[r][c] == 'E':
                    end_r, end_c = r, c
                elif grid[r][c] == 'T':
                    all_T_cells.append((r, c))

        dist = {}
        q = collections.deque()

        teleport_supernode_id = (-1, -1) 

        dist[(start_r, start_c)] = 0
        q.append((start_r, start_c))

        dr = [-1, 1, 0, 0]
        dc = [0, 0, -1, 1]

        while q:
            curr_node = q.popleft()
            d = dist[curr_node]

            if curr_node == (end_r, end_c):
                return d

            if curr_node == teleport_supernode_id:
                for tr, tc in all_T_cells:
                    if d < dist.get((tr, tc), float('inf')):
                        dist[(tr, tc)] = d
                        q.appendleft((tr, tc))
            else:
                r, c = curr_node

                if grid[r][c] == 'T':
                    if d < dist.get(teleport_supernode_id, float('inf')):
                        dist[teleport_supernode_id] = d
                        q.appendleft(teleport_supernode_id)

                for i in range(4):
                    nr, nc = r + dr[i], c + dc[i]

                    if 0 <= nr < R and 0 <= nc < C and grid[nr][nc] != '#':
                        if d + 1 < dist.get((nr, nc), float('inf')):
                            dist[(nr, nc)] = d + 1
                            q.append((nr, nc))

        return -1