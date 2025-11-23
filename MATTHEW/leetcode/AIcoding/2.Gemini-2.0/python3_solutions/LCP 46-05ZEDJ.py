class Solution:
    def volunteerDeployment(self, finalCnt: list[int], edges: list[list[int]], plans: list[list[int]]) -> list[int]:
        n = len(finalCnt)
        adj = [[] for _ in range(n + 1)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        in_degree = [len(adj[i]) for i in range(n + 1)]
        in_degree[0] = 0

        equations = [([0] * (n + 1), 0) for _ in range(n + 1)]
        equations[0] = ([1] * (n + 1), 0)
        for i in range(1, n + 1):
            equations[i][0][i] = 1
            equations[i][1] = finalCnt[i - 1]

        for t, i, val in reversed(plans):
            if t == 1:
                equations[i][1] -= val
                equations[i][0][i] -= 1
                for nei in adj[i]:
                    equations[nei][1] += val
                    equations[nei][0][nei] += 1
            else:
                equations[i][1] += val
                equations[i][0][i] += 1
                for nei in adj[i]:
                    equations[nei][1] -= val
                    equations[nei][0][nei] -= 1

        a = [row[0] for row in equations]
        b = [row[1] for row in equations]

        def solve_linear_equations(a, b):
            n = len(a)
            m = len(a[0])
            aug_matrix = [a[i] + [b[i]] for i in range(n)]

            for i in range(m):
                pivot_row = i
                for j in range(i + 1, n):
                    if abs(aug_matrix[j][i]) > abs(aug_matrix[pivot_row][i]):
                        pivot_row = j

                aug_matrix[i], aug_matrix[pivot_row] = aug_matrix[pivot_row], aug_matrix[i]

                pivot_val = aug_matrix[i][i]
                if abs(pivot_val) < 1e-9:
                    return None

                for j in range(m + 1):
                    aug_matrix[i][j] /= pivot_val

                for j in range(n):
                    if j != i:
                        factor = aug_matrix[j][i]
                        for k in range(m + 1):
                            aug_matrix[j][k] -= factor * aug_matrix[i][k]

            solution = [aug_matrix[i][m] for i in range(m)]
            return solution

        solution = solve_linear_equations(a, b)

        if solution is None:
            return []

        x = round(solution[0])
        if not (1 <= x <= 10**9):
            return []

        result = [round(solution[i]) for i in range(1, n + 1)]

        for i in range(n):
            result[i] += x

        for val in result:
            if not (1 <= val <= 10**9):
                return []

        return result