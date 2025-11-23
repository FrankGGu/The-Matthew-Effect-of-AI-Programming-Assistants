class Solution:
    def distinctDifferenceArray(self, nums: List[int]) -> List[int]:
        n = len(nums)
        prefix = [0] * n
        suffix = [0] * n
        seen_prefix = set()
        seen_suffix = set()

        for i in range(n):
            seen_prefix.add(nums[i])
            prefix[i] = len(seen_prefix)

        for i in range(n-1, -1, -1):
            seen_suffix.add(nums[i])
            suffix[i] = len(seen_suffix)

        res = []
        for i in range(n):
            left = prefix[i]
            right = suffix[i+1] if i+1 < n else 0
            res.append(left - right)

        return res