class Solution:
    def edgeScore(self, edges: List[int]) -> int:
        scores = [0] * len(edges)
        for i, node in enumerate(edges):
            scores[node] += i
        max_score = max(scores)
        for i, score in enumerate(scores):
            if score == max_score:
                return i
        return -1