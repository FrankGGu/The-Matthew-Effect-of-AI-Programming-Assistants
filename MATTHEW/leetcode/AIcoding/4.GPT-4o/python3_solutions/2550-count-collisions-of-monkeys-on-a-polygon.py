class Solution:
    def monkeyCollision(self, n: int, edges: List[int]) -> int:
        count = 0
        for i in range(n):
            if edges[i] != -1 and edges[edges[i]] == i:
                count += 2
                edges[i] = edges[edges[i]] = -1
        return count