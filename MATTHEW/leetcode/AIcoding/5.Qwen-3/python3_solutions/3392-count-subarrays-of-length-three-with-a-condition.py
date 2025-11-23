class Solution:
    def countOfSubarrays(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        count[0] = 1
        res = 0
        curr = 0

        for num in nums:
            curr += num
            if curr - k in count:
                res += count[curr - k]
            count[curr] += 1

        return res