class Solution:
    def maximumSegmentSum(self, nums: List[int], removeQueries: List[int]) -> List[int]:
        n = len(nums)
        uf = {}
        sums = {}
        ans = []
        max_sum = 0

        def find(x):
            if x not in uf:
                return x
            uf[x] = find(uf[x])
            return uf[x]

        def union(x, y):
            root_x = find(x)
            root_y = find(y)
            if root_x != root_y:
                uf[root_x] = root_y
                sums[root_y] += sums[root_x]
                return sums[root_y]
            return sums[root_x]

        present = [False] * n
        for i in range(n - 1, -1, -1):
            remove_index = removeQueries[i]
            present[remove_index] = True
            sums[remove_index] = nums[remove_index]

            if remove_index > 0 and present[remove_index - 1]:
                max_sum = max(max_sum, union(remove_index - 1, remove_index))
            if remove_index < n - 1 and present[remove_index + 1]:
                max_sum = max(max_sum, union(remove_index, remove_index + 1))

            ans.append(max_sum)

        return ans[::-1]