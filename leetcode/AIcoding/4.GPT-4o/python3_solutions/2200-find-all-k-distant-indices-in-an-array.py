class Solution:
    def findKDistantIndices(self, nums: List[int], key: int, k: int) -> List[int]:
        key_indices = [i for i, num in enumerate(nums) if num == key]
        result = set()

        for index in key_indices:
            for i in range(max(0, index - k), min(len(nums), index + k + 1)):
                result.add(i)

        return sorted(result)