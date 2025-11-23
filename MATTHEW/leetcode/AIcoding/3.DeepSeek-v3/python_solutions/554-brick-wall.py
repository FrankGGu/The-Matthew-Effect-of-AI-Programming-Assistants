class Solution:
    def leastBricks(self, wall: List[List[int]]) -> int:
        edge_counts = {}
        max_edges = 0

        for row in wall:
            edge_pos = 0
            for brick in row[:-1]:
                edge_pos += brick
                edge_counts[edge_pos] = edge_counts.get(edge_pos, 0) + 1
                max_edges = max(max_edges, edge_counts[edge_pos])

        return len(wall) - max_edges