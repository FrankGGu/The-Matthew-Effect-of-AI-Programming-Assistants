class Solution:
    def lexicographicallySmallestArray(self, nums: List[int], limit: int) -> List[int]:
        n = len(nums)
        indices = list(range(n))
        indices.sort(key=lambda x: nums[x])
        groups = []
        current_group = [indices[0]]

        for i in range(1, n):
            if nums[indices[i]] - nums[indices[i-1]] <= limit:
                current_group.append(indices[i])
            else:
                groups.append(current_group)
                current_group = [indices[i]]
        groups.append(current_group)

        res = [0] * n
        for group in groups:
            sorted_group = sorted(group)
            values = sorted([nums[i] for i in group])
            for idx, val in zip(sorted_group, values):
                res[idx] = val
        return res