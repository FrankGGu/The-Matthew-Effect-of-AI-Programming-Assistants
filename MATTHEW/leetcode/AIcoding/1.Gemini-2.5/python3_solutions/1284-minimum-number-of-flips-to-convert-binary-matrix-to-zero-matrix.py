import collections

class Solution:
    def minFlips(self, mat: list[list[int]]) -> int:
        m = len(mat)
        n = len(mat[0])

        def list_to_tuple(l_mat):
            return tuple(tuple(row) for row in l_mat)

        def tuple_to_list(t_mat):
            return [list(row) for row in t_mat]

        def is_zero_matrix(t_mat):
            for r in range(m):
                for c in range(n):
                    if t_mat[r][c] == 1:
                        return False
            return True

        def get_next_state(t_mat, r_flip, c_flip):
            temp_mat = tuple_to_list(t_mat)

            directions = [(0, 0), (0, 1), (0, -1), (1, 0), (-1, 0)]

            for dr, dc in directions:
                nr, nc = r_flip + dr, c_flip + dc
                if 0 <= nr < m and 0 <= nc < n:
                    temp_mat[nr][nc] ^= 1 

            return list_to_tuple(temp_mat)

        initial_state = list_to_tuple(mat)

        queue = collections.deque([(initial_state, 0)])
        visited = {initial_state}

        while queue:
            current_mat_tuple, flips = queue.popleft()

            if is_zero_matrix(current_mat_tuple):
                return flips

            for r in range(m):
                for c in range(n):
                    next_mat_tuple = get_next_state(current_mat_tuple, r, c)
                    if next_mat_tuple not in visited:
                        visited.add(next_mat_tuple)
                        queue.append((next_mat_tuple, flips + 1))

        return -1