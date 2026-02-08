from collections import Counter

class Solution:
    def maximumLength(self, nums: list[int]) -> int:
        counts = Counter(nums)
        nums = sorted(list(set(nums)))
        ans = 0
        if 1 in counts:
            ans = counts[1] if counts[1] % 2 == 1 else counts[1] - 1
        for num in nums:
            if num == 1:
                continue
            length = 0
            curr = num
            while curr in counts:
                length += 1
                if counts[curr] > 1 and length == 1:
                    length += 1
                curr *= curr
            ans = max(ans, length if length % 2 == 1 else length -1)
        return ans