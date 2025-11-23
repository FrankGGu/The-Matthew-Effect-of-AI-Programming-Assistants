class Solution:
    def edgeScore(self, edges: List[int]) -> int:
        score = [0] * len(edges)
        for i, node in enumerate(edges):
            score[node] += i
        return max(range(len(score)), key=lambda i: (score[i], i))