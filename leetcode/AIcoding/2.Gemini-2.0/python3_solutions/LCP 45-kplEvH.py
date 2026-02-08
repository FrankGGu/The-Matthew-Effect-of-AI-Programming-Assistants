class Solution:
    def isPossible(self, n: int, edges: List[List[int]]) -> bool:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u - 1].append(v - 1)
            adj[v - 1].append(u - 1)

        odd_nodes = []
        for i in range(n):
            if len(adj[i]) % 2 != 0:
                odd_nodes.append(i)

        if not odd_nodes:
            return True

        if len(odd_nodes) > 8:
            return False

        m = len(odd_nodes)
        if m == 2:
            u, v = odd_nodes
            if v in adj[u]:
                for i in range(n):
                    if i != u and i != v and (u not in adj[i]) and (v not in adj[i]):
                        return True
                return False
            else:
                return True

        if m == 4:
            for i in range(1 << 4):
                a, b, c, d = odd_nodes
                p1, p2 = -1, -1
                q1, q2 = -1, -1

                if (i >> 0) & 1:
                    p1, p2 = a, b
                else:
                    q1, q2 = a, b

                if (i >> 1) & 1:
                    if p1 == -1:
                        p1, p2 = a, c
                    else:
                        q1, q2 = a, c
                else:
                    if q1 == -1:
                        p1, p2 = a, c
                    else:
                        q1, q2 = a, c

                if (i >> 2) & 1:
                    if p1 == -1:
                        p1, p2 = a, d
                    else:
                        q1, q2 = a, d
                else:
                    if q1 == -1:
                        p1, p2 = a, d
                    else:
                        q1, q2 = a, d

                if (i >> 3) & 1:
                    if p1 == -1:
                        p1, p2 = b, c
                        q1, q2 = a, d
                    else:
                        q1, q2 = b, c
                        p1, p2 = a, d
                else:
                    if q1 == -1:
                        p1, p2 = b, c
                        q1, q2 = a, d
                    else:
                        q1, q2 = b, c
                        p1, p2 = a, d

                p1_val = False
                q1_val = False

                if p1 != -1 and p2 != -1:
                    if p2 not in adj[p1]:
                        p1_val = True

                if q1 != -1 and q2 != -1:
                    if q2 not in adj[q1]:
                        q1_val = True

                if p1_val and q1_val:
                    return True

            return False

        return False