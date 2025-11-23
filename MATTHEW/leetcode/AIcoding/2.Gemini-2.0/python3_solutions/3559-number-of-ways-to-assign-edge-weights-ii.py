from collections import defaultdict

class Solution:
    def countPaths(self, n: int, edges: list[list[int]]) -> list[int]:
        adj = defaultdict(list)
        rev_adj = defaultdict(list)
        edge_idx = {}
        for i, (u, v) in enumerate(edges):
            adj[u].append(v)
            rev_adj[v].append(u)
            edge_idx[(u, v)] = i

        in_degree = [0] * (n + 1)
        out_degree = [0] * (n + 1)
        for u, v in edges:
            out_degree[u] += 1
            in_degree[v] += 1

        zero_cnt = sum(1 for i in range(1, n + 1) if in_degree[i] == 0 and out_degree[i] == 0)

        def solve(start, end, adj):
            visited = [False] * (n + 1)
            q = [(start, [])]
            paths = []

            while q:
                u, path = q.pop(0)
                if visited[u]:
                    continue
                visited[u] = True

                if u == end:
                    paths.append(path)
                    continue

                for v in adj[u]:
                    q.append((v, path + [(u, v)]))

            return paths

        pos_paths = solve(1, n, adj)
        neg_paths = solve(n, 1, rev_adj)

        pos_cnt = len(pos_paths)
        neg_cnt = len(neg_paths)

        same_cnt = 0
        diff_cnt = 0

        for pos_path in pos_paths:
            for neg_path in neg_paths:

                edge_set1 = set(edge_idx[(u,v)] for u,v in pos_path)
                edge_set2 = set(edge_idx[(u,v)] for u,v in neg_path)

                if len(edge_set1.intersection(edge_set2)) == 0:
                    diff_cnt += 1
                else:
                    same_cnt += 1

        return [same_cnt, diff_cnt]