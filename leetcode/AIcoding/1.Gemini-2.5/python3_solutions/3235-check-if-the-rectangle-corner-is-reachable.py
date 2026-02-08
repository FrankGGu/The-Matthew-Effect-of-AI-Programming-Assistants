import math

class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            if self.rank[root_i] < self.rank[root_j]:
                self.parent[root_i] = root_j
            elif self.rank[root_i] > self.rank[root_j]:
                self.parent[root_j] = root_i
            else:
                self.parent[root_j] = root_i
                self.rank[root_i] += 1
            return True
        return False

class Solution:
    def canReachCorner(self, width: int, height: int, circles: list[list[int]]) -> bool:
        num_circles = len(circles)

        # Virtual nodes for boundaries:
        # num_circles: left wall (x=0)
        # num_circles + 1: right wall (x=width)
        # num_circles + 2: bottom wall (y=0)
        # num_circles + 3: top wall (y=height)
        dsu = DSU(num_circles + 4)

        # Connect circles to boundaries
        for i in range(num_circles):
            cx, cy, r = circles[i]
            if cx - r <= 0:  # Touches or crosses left wall
                dsu.union(i, num_circles)
            if cx + r >= width:  # Touches or crosses right wall
                dsu.union(i, num_circles + 1)
            if cy - r <= 0:  # Touches or crosses bottom wall
                dsu.union(i, num_circles + 2)
            if cy + r >= height:  # Touches or crosses top wall
                dsu.union(i, num_circles + 3)

        # Connect circles to each other if they overlap
        for i in range(num_circles):
            for j in range(i + 1, num_circles):
                cx1, cy1, r1 = circles[i]
                cx2, cy2, r2 = circles[j]

                # Distance squared between centers
                dist_sq = (cx1 - cx2)**2 + (cy1 - cy2)**2
                # (r1 + r2)^2
                radii_sum_sq = (r1 + r2)**2

                if dist_sq <= radii_sum_sq:
                    dsu.union(i, j)

        # The path from (0,0) to (width, height) is blocked if:
        # 1. The left boundary is connected to the top boundary.
        # 2. The bottom boundary is connected to the right boundary.
        # If either of these conditions is true, it's impossible to reach the target corner.

        # Check if left wall is connected to top wall
        is_blocked_LT = (dsu.find(num_circles) == dsu.find(num_circles + 3))

        # Check if bottom wall is connected to right wall
        is_blocked_BR = (dsu.find(num_circles + 2) == dsu.find(num_circles + 1))

        return not (is_blocked_LT or is_blocked_BR)