class Solution:
    def sumImbalanceNumbers(self, nums: List[int]) -> int:
        n = len(nums)
        res = 0
        for i in range(n):
            seen = set()
            seen.add(nums[i])
            current = 0
            for j in range(i + 1, n):
                x = nums[j]
                if x not in seen:
                    cnt = 1
                    if x + 1 in seen:
                        cnt -= 1
                    if x - 1 in seen:
                        cnt -= 1
                    current += cnt
                    seen.add(x)
                res += current
        return res