from collections import defaultdict

class Solution:
    def maxEdgeScore(self, edges: list[int]) -> int:
        scores = defaultdict(int)
        for i, edge in enumerate(edges):
            scores[edge] += i

        max_score = 0
        max_node = -1

        for node, score in scores.items():
            if score > max_score:
                max_score = score
                max_node = node
            elif score == max_score and node < max_node:
                max_node = node

        return max_node