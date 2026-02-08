class Solution:
    def volunteerDeployment(self, finalCnt: List[int], totalNum: int, edges: List[List[int]], plans: List[List[int]]) -> List[int]:
        n = len(finalCnt) + 1
        coeff = [0] * n
        const = [0] * n
        coeff[0] = 1
        const[0] = 0
        for i in range(1, n):
            coeff[i] = 0
            const[i] = finalCnt[i-1]

        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        for plan in reversed(plans):
            num, idx = plan
            if num == 1:
                coeff[idx] *= 2
                const[idx] *= 2
            else:
                neighbors = adj[idx]
                for neighbor in neighbors:
                    if num == 2:
                        coeff[neighbor] -= coeff[idx]
                        const[neighbor] -= const[idx]
                    elif num == 3:
                        coeff[neighbor] += coeff[idx]
                        const[neighbor] += const[idx]

        total_coeff = sum(coeff)
        total_const = sum(const)
        x = (totalNum - total_const) // total_coeff

        res = []
        for i in range(n):
            res.append(coeff[i] * x + const[i])
        return res