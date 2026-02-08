class Solution:
    def findSmallestSetOfVertices(self, n: int, edges: List[List[int]]) -> List[int]:
        has_incoming_edge = [False] * n

        for _from, _to in edges:
            has_incoming_edge[_to] = True

        result = []
        for i in range(n):
            if not has_incoming_edge[i]:
                result.append(i)

        return result