class DSU:
    def __init__(self, n: int):
        self.parent = list(range(n))
        # segment_sum[i] stores the sum of elements in the segment if i is the root of its set.
        self.segment_sum = [0] * n 
        # max_sum tracks the maximum segment sum found across all active segments.
        self.max_sum = 0 

    def find(self, i: int) -> int:
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i: int, j: int) -> bool:
        root_i = self.find(i)
        root_j = self.find(j)

        if root_i != root_j:
            # Merge root_j's segment into root_i's segment
            self.parent[root_j] = root_i
            self.segment_sum[root_i] += self.segment_sum[root_j]
            # Update the global maximum sum if the newly merged segment sum is greater
            self.max_sum = max(self.max_sum, self.segment_sum[root_i])
            return True
        return False

class Solution:
    def maximumSegmentSum(self, nums: list[int], removals: list[int]) -> list[int]:
        n = len(nums)
        m = len(removals)

        # The result array, to be filled in reverse order.
        ans = [0] * m

        # Initialize DSU structure.
        dsu = DSU(n)

        # present[i] is True if nums[i] is currently considered "present" (not removed).
        # Initially, all elements are considered removed for the reverse process.
        present = [False] * n

        # Iterate through removals in reverse order.
        # This simulates adding elements back one by one.
        for i in range(m - 1, -1, -1):
            # The maximum segment sum *before* adding back removals[i]
            # corresponds to the state *after* the i-th removal in the forward process.
            ans[i] = dsu.max_sum

            idx = removals[i]
            present[idx] = True

            # When an element is added back, it initially forms a segment of its own.
            dsu.segment_sum[idx] = nums[idx]
            # Update the global maximum sum, as a single element can be the new max.
            dsu.max_sum = max(dsu.max_sum, nums[idx])

            # Check and merge with left neighbor if it's present.
            if idx - 1 >= 0 and present[idx - 1]:
                dsu.union(idx, idx - 1)

            # Check and merge with right neighbor if it's present.
            if idx + 1 < n and present[idx + 1]:
                dsu.union(idx, idx + 1)

        return ans