class Solution:
    def mctFromLeafTree(self, arr: List[int]) -> int:
        def dfs(i, j):
            if i == j:
                return 0, arr[i]
            min_cost = float('inf')
            max_val = 0
            for k in range(i, j):
                left_cost, left_max = dfs(i, k)
                right_cost, right_max = dfs(k + 1, j)
                cost = left_cost + right_cost + left_max * right_max
                if cost < min_cost:
                    min_cost = cost
                    max_val = max(left_max, right_max)
            return min_cost, max_val

        return dfs(0, len(arr) - 1)[0]