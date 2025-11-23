class Solution:
    def bestRotation(self, nums: List[int]) -> int:
        n = len(nums)
        diff = [0] * (n + 1)

        for i in range(n):
            a = (i - nums[i] + 1) % n
            b = (i + 1) % n
            if a <= b:
                diff[a] += 1
                diff[b] -= 1
            else:
                diff[a] += 1
                diff[0] += 1
                diff[b] -= 1

        max_score = 0
        res = 0
        current = 0

        for k in range(n):
            current += diff[k]
            if current > max_score:
                max_score = current
                res = k

        return res