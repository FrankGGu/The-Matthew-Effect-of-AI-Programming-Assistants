class Solution:
    def edgeScore(self, edges: list[int]) -> int:
        n = len(edges)
        scores = [0] * n

        for i in range(n):
            target_node = edges[i]
            scores[target_node] += i

        max_score = -1
        result_node = -1

        for i in range(n):
            if scores[i] > max_score:
                max_score = scores[i]
                result_node = i

        return result_node