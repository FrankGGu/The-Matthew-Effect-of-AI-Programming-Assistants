class Solution:
    def findClosestNode(self, n: int, edges: list[int], node1: int, node2: int) -> int:

        def get_distances(start_node: int, n: int, edges: list[int]) -> list[int]:
            distances = [-1] * n
            current_node = start_node
            current_dist = 0
            while current_node != -1 and distances[current_node] == -1:
                distances[current_node] = current_dist
                current_node = edges[current_node]
                current_dist += 1
            return distances

        dist1 = get_distances(node1, n, edges)
        dist2 = get_distances(node2, n, edges)

        min_max_dist = float('inf')
        result_node = -1

        for i in range(n):
            if dist1[i] != -1 and dist2[i] != -1:
                current_max_dist = max(dist1[i], dist2[i])
                if current_max_dist < min_max_dist:
                    min_max_dist = current_max_dist
                    result_node = i

        return result_node