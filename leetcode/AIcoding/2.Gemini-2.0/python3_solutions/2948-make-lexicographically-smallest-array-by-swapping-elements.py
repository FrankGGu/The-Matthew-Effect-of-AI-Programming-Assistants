class Solution:
    def lexicographicallySmallestArray(self, nums: list[int], limit: int) -> list[int]:
        n = len(nums)
        indices = sorted(range(n), key=lambda i: nums[i])

        res = [0] * n
        visited = [False] * n

        for i in range(n):
            if visited[i]:
                continue

            group = []
            curr = i

            while curr < n:
                idx = indices[curr]
                if not visited[idx]:
                    group.append(idx)
                    visited[idx] = True
                curr += 1
                if curr < n:
                    next_idx = indices[curr]
                    if abs(nums[idx] - nums[next_idx]) > limit:
                        break

            group.sort()
            values = [nums[idx] for idx in group]
            values.sort()

            for j in range(len(group)):
                res[group[j]] = values[j]

        return res