class Solution:
    def maxNumberOfAlloys(self, n: int, k: int, budget: int, composition: List[List[int]], stock: List[int], cost: List[int]) -> int:
        left = 0
        right = 2 * 10**8
        answer = 0

        def is_possible(target):
            min_cost = float('inf')
            for comp in composition:
                total_cost = 0
                for i in range(n):
                    needed = comp[i] * target - stock[i]
                    if needed > 0:
                        total_cost += needed * cost[i]
                    if total_cost > budget:
                        break
                if total_cost <= budget:
                    return True
            return False

        while left <= right:
            mid = (left + right) // 2
            if is_possible(mid):
                answer = mid
                left = mid + 1
            else:
                right = mid - 1
        return answer