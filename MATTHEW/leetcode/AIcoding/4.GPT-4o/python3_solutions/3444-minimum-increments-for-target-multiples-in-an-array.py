class Solution:
    def minIncrements(self, n: int, cost: List[int], target: int) -> int:
        def dfs(node):
            if node >= n:
                return 0, 0
            left_cost, left_sum = dfs(2 * node + 1)
            right_cost, right_sum = dfs(2 * node + 2)
            total_sum = left_sum + right_sum + cost[node]
            if total_sum < target:
                return target - total_sum + left_cost + right_cost, total_sum
            return left_cost + right_cost, total_sum

        total_cost, _ = dfs(0)
        return total_cost