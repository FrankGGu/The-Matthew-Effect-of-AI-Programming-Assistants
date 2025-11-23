class Solution:
    def sumOfSubarrayBeauties(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        res = 0
        for i in range(len(nums)):
            if i >= k:
                count[nums[i - k]] -= 1
                if count[nums[i - k]] == 0:
                    del count[nums[i - k]]
            if i >= k - 1:
                total = 0
                for key in count:
                    total += key * count[key]
                res += total // len(count)
        return res