from collections import deque
import heapq

class Solution:
    def minimalSteps(self, maze: list[str]) -> int:
        rows, cols = len(maze), len(maze[0])

        # 1. Identify Special Points
        start_pos = None
        magic_points = []
        treasure_points = []

        for r in range(rows):
            for c in range(cols):
                if maze[r][c] == 'S':
                    start_pos = (r, c)
                elif maze[r][c] == 'M':
                    magic_points.append((r, c))
                elif maze[r][c] == 'T':
                    treasure_points.append((r, c))

        num_treasures = len(treasure_points)
        num_magic = len(magic_points)

        if num_treasures == 0:
            return 0

        # Helper BFS function to find shortest distance from (sr, sc) to all other cells,
        # along with the mask of treasures collected on the path.
        def bfs_with_mask(sr, sc):
            q = deque()
            visited = set()
            results = {} # {(r,c): (dist, mask)}

            # Calculate initial mask for the starting position itself
            initial_mask = 0
            for k in range(num_treasures):
                if (sr, sc) == treasure_points[k]:
                    initial_mask |= (1 << k)

            q.append((sr, sc, 0, initial_mask))
            visited.add((sr, sc))
            results[(sr, sc)] = (0, initial_mask)

            while q:
                r, c, d, current_mask = q.popleft()

                for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                    nr, nc = r + dr, c + dc
                    if 0 <= nr < rows and 0 <= nc < cols and maze[nr][nc] != '#' and (nr, nc) not in visited:
                        visited.add((nr, nc))

                        new_mask = current_mask
                        for k in range(num_treasures):
                            if (nr, nc) == treasure_points[k]:
                                new_mask |= (1 << k)

                        results[(nr, nc)] = (d + 1, new_mask)
                        q.append((nr, nc, d + 1, new_mask))
            return results

        # Store all special points for indexing: S, then M's, then T's
        # Global indices: 0 for S, 1 to num_magic for M's, num_magic+1 to num_magic+num_treasures for T's
        all_special_points = [start_pos] + magic_points + treasure_points
        num_all_special = len(all_special_points)

        # Precompute BFS results from each special point
        all_bfs_results = [None] * num_all_special
        for i in range(num_all_special):
            r, c = all_special_points[i]
            all_bfs_results[i] = bfs_with_mask(r, c)

        # DP state: dp[mask][m_idx] = min moves to collect treasures in 'mask', ending at magic_points[m_idx]
        # m_idx: index within magic_points list (0 to num_magic-1)
        dp = [[float('inf')] * num_magic for _ in range(1 << num_treasures)]

        # Initialize DP table with base cases (from S to M_i)
        # S is all_special_points[0]
        for i in range(num_magic):
            m_pos = magic_points[i] # (r,c) of the i-th magic point

            if m_pos in all_bfs_results[0]: # Check if M_i is reachable from S
                d_sm, mask_sm = all_bfs_results[0][m_pos]
                if d_sm != float('inf'):
                    dp[mask_sm][i] = min(dp[mask_sm][i], d_sm)

        # Dijkstra-like approach for DP transitions
        pq = []
        for mask in range(1 << num_treasures):
            for i in range(num_magic):
                if dp[mask][i] != float('inf'):
                    heapq.heappush(pq, (dp[mask][i], mask, i))

        final_ans = float('inf')
        target_mask = (1 << num_treasures) - 1

        while pq:
            cost, current_mask, current_m_idx = heapq.heappop(pq)

            if cost > dp[current_mask][current_m_idx]:
                continue

            # If all treasures collected, update answer
            if current_mask == target_mask:
                final_ans = min(final_ans, cost)
                continue

            # Option 1: Teleport from current_m_idx to another magic point next_m_idx (cost 0)
            # This makes all M's reachable from each other for free once you are at one M.
            for next_m_idx in range(num_magic):
                if current_m_idx != next_m_idx:
                    if cost < dp[current_mask][next_m_idx]:
                        dp[current_mask][next_m_idx] = cost
                        heapq.heappush(pq, (cost, current_mask, next_m_idx))

            # Option 2: Move from magic_points[current_m_idx] to collect a new treasure and reach another magic point
            # M_i -> T_k -> M_j
            # M_i is magic_points[current_m_idx] (global index 1 + current_m_idx)
            # T_k is treasure_points[k] (global index 1 + num_magic + k)
            # M_j is magic_points[next_m_idx] (global index 1 + next_m_idx)

            for k in range(num_treasures):
                if not (current_mask & (1 << k)): # If treasure k is not collected
                    # Get path from M_i to T_k
                    t_k_pos = treasure_points[k]

                    if t_k_pos not in all_bfs_results[1 + current_m_idx]:
                        continue # T_k is unreachable from M_i

                    d_mt, mask_mt = all_bfs_results[1 + current_m_idx][t_k_pos]
                    if d_mt == float('inf'):
                        continue

                    # New mask after reaching T_k (including T_k itself and any on path)
                    new_mask_after_t = current_mask | mask_mt | (1 << k)

                    # Now, from T_k, move to any M_j
                    for next_m_idx in range(num_magic):
                        m_j_pos = magic_points[next_m_idx]

                        if m_j_pos not in all_bfs_results[1 + num_magic + k]:
                            continue # M_j is unreachable from T_k

                        d_tm, mask_tm = all_bfs_results[1 + num_magic + k][m_j_pos]
                        if d_tm == float('inf'):
                            continue

                        final_new_mask = new_mask_after_t | mask_tm
                        total_new_cost = cost + d_mt + d_tm

                        if total_new_cost < dp[final_new_mask][next_m_idx]:
                            dp[final_new_mask][next_m_idx] = total_new_cost
                            heapq.heappush(pq, (total_new_cost, final_new_mask, next_m_idx))

        if final_ans == float('inf'):
            return -1
        return final_ans