import collections

class Solution:
    def isEscapePossible(self, blocked: list[list[int]], source: list[int], target: list[int]) -> bool:
        blocked_set = set(tuple(b) for b in blocked)

        # The maximum number of cells N blocks can enclose is N * (N-1) / 2.
        # For N=200, this is 200 * 199 / 2 = 19900.
        # If a BFS explores more cells than this, it means it has escaped
        # any finite region that can be formed by the blocked cells.
        # We use a slightly larger constant (e.g., 200 * 200 = 40000) as a safe upper bound.
        MAX_VISIT = 200 * 200

        def bfs(start, end, blocked_cells):
            q = collections.deque([(start[0], start[1])])
            visited = {(start[0], start[1])}

            if start[0] == end[0] and start[1] == end[1]:
                return True

            count = 0

            grid_limit = 10**6

            dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]

            while q:
                r, c = q.popleft()

                count += 1
                if count > MAX_VISIT:
                    return True 

                for dr, dc in dirs:
                    nr, nc = r + dr, c + dc

                    if 0 <= nr < grid_limit and 0 <= nc < grid_limit and \
                       (nr, nc) not in blocked_cells and (nr, nc) not in visited:

                        if nr == end[0] and nc == end[1]:
                            return True 

                        visited.add((nr, nc))
                        q.append((nr, nc))

            return False 

        if not bfs(source, target, blocked_set):
            return False 

        return bfs(target, source, blocked_set)