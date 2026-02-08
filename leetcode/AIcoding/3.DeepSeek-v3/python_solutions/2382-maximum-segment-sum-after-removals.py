class Solution:
    def maximumSegmentSum(self, nums: List[int], removeQueries: List[int]) -> List[int]:
        n = len(nums)
        parent = list(range(n))
        sum_val = [0] * n
        res = [0] * n
        max_sum = 0

        for i in range(n - 1, -1, -1):
            res[i] = max_sum
            q = removeQueries[i]
            sum_val[q] = nums[q]
            if q > 0 and sum_val[q - 1] > 0:
                self.union(parent, sum_val, q - 1, q)
            if q < n - 1 and sum_val[q + 1] > 0:
                self.union(parent, sum_val, q, q + 1)
            max_sum = max(max_sum, sum_val[self.find(parent, q)])

        return res

    def find(self, parent, x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    def union(self, parent, sum_val, x, y):
        fx = self.find(parent, x)
        fy = self.find(parent, y)
        if fx != fy:
            parent[fy] = fx
            sum_val[fx] += sum_val[fy]