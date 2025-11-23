class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        most_common = count.most_common(2)

        if len(most_common) == 1:
            return len(nums) - most_common[0][1]

        first, second = most_common[0], most_common[1]

        if first[0] == second[0] + 1:
            return len(nums) - first[1] - second[1]

        return len(nums) - first[1]