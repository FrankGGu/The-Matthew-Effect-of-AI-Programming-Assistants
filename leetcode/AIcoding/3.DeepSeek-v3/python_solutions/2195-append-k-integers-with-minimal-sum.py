class Solution:
    def minimalKSum(self, nums: List[int], k: int) -> int:
        nums = sorted(list(set(nums)))
        res = 0
        prev = 0
        for num in nums:
            if num > prev + 1:
                count = min(num - prev - 1, k)
                res += (prev + 1 + prev + count) * count // 2
                k -= count
                if k == 0:
                    break
            prev = num
        if k > 0:
            res += (prev + 1 + prev + k) * k // 2
        return res