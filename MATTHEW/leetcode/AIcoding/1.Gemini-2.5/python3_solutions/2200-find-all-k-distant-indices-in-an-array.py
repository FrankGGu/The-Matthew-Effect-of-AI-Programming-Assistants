class Solution:
    def findKDistantIndices(self, nums: list[int], key: int, k: int) -> list[int]:
        n = len(nums)
        key_indices = []
        for j in range(n):
            if nums[j] == key:
                key_indices.append(j)

        k_distant_indices = set()
        for j in key_indices:
            for i in range(max(0, j - k), min(n, j + k + 1)):
                k_distant_indices.add(i)

        return sorted(list(k_distant_indices))