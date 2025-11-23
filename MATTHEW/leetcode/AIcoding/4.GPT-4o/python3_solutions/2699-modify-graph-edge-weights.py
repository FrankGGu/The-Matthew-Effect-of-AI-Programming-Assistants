class Solution:
    def modifyGraph(self, edges: List[List[int]], inc: List[int]) -> List[List[int]]:
        n = len(inc)
        result = []
        for u, v in edges:
            if u > v:
                u, v = v, u
            result.append([u, v, inc[u] + inc[v]])
        return result