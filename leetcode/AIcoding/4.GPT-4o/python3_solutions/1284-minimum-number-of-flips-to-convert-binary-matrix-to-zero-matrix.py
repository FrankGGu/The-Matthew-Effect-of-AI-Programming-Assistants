class Solution:
    def minFlips(self, mat: List[List[int]]) -> int:
        from collections import deque

        def to_tuple(m):
            return tuple(tuple(row) for row in m)

        start = to_tuple(mat)
        target = to_tuple([[0] * len(mat[0]) for _ in range(len(mat))])

        if start == target:
            return 0

        directions = [(0, 0), (0, 1), (1, 0), (1, 1)]
        queue = deque([start])
        visited = {start}
        flips = 0

        while queue:
            flips += 1
            for _ in range(len(queue)):
                current = queue.popleft()
                for i in range(len(current)):
                    for j in range(len(current[0])):
                        new_mat = [list(row) for row in current]
                        for di, dj in directions:
                            ni, nj = i + di, j + dj
                            if 0 <= ni < len(current) and 0 <= nj < len(current[0]):
                                new_mat[ni][nj] ^= 1
                        new_tuple = to_tuple(new_mat)
                        if new_tuple == target:
                            return flips
                        if new_tuple not in visited:
                            visited.add(new_tuple)
                            queue.append(new_tuple)
        return -1