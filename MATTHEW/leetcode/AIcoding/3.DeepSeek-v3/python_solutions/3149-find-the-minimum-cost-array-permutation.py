class Solution:
    def findPermutation(self, nums: List[int]) -> List[int]:
        n = len(nums)
        self.min_cost = float('inf')
        self.res = []
        visited = [False] * n

        def backtrack(path, cost):
            if len(path) == n:
                total_cost = cost + abs(path[-1] - nums[path[0]])
                if total_cost < self.min_cost:
                    self.min_cost = total_cost
                    self.res = path.copy()
                return

            for i in range(n):
                if not visited[i]:
                    visited[i] = True
                    new_cost = cost + (abs(path[-1] - nums[i]) if path else 0)
                    backtrack(path + [i], new_cost)
                    visited[i] = False

        backtrack([], 0)
        return self.res