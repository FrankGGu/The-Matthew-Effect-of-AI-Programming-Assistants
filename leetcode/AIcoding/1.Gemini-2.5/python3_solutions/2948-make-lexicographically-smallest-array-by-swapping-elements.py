class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        # Stores values belonging to the component rooted at index i
        self.component_values = [[] for _ in range(n)]
        # Stores original indices belonging to the component rooted at index i
        self.component_indices = [[] for _ in range(n)]

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)

        if root_i != root_j:
            # Merge j's component into i's component
            self.parent[root_j] = root_i
            self.component_values[root_i].extend(self.component_values[root_j])
            self.component_indices[root_i].extend(self.component_indices[root_j])

            # Clear the merged component's data to save memory and avoid redundant processing
            self.component_values[root_j] = []
            self.component_indices[root_j] = []
            return True
        return False

class Solution:
    def makeSmallestArray(self, nums: list[int], limit: int) -> list[int]:
        n = len(nums)
        dsu = DSU(n)

        # Create pairs of (value, original_index)
        # Also initialize DSU component data for each individual element
        pairs = []
        for i in range(n):
            pairs.append((nums[i], i))
            dsu.component_values[i].append(nums[i])
            dsu.component_indices[i].append(i)

        # Sort pairs by value to efficiently find elements that can be swapped
        pairs.sort()

        # Iterate through sorted pairs and union components
        # If two adjacent elements in the sorted list can be swapped (abs(diff) <= limit),
        # then their original indices belong to the same connected component.
        # Due to transitivity, this correctly groups all elements that can be swapped.
        for k in range(n - 1):
            val1, idx1 = pairs[k]
            val2, idx2 = pairs[k+1]
            if val2 - val1 <= limit:
                dsu.union(idx1, idx2)

        # Build the result array
        ans = [0] * n
        for i in range(n):
            # If 'i' is a root of a component (i.e., it represents a component)
            if dsu.parent[i] == i:
                # Get the values and indices for this component
                component_vals = dsu.component_values[i]
                component_idxs = dsu.component_indices[i]

                # Sort both lists. To make the array lexicographically smallest,
                # we put the smallest values into the smallest available indices within the component.
                component_vals.sort()
                component_idxs.sort()

                # Assign sorted values to sorted indices
                for k in range(len(component_vals)):
                    ans[component_idxs[k]] = component_vals[k]

        return ans