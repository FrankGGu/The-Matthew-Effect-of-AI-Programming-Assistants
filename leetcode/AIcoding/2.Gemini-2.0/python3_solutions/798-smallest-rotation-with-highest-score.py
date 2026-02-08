class Solution:
    def smallestRotation(self, nums: list[int]) -> int:
        n = len(nums)
        bad = [0] * n
        for i, num in enumerate(nums):
            low = (i - num + 1 + n) % n
            high = (i + 1) % n
            bad[low] -= 1
            bad[high] += 1
            if low > high:
                bad[0] += 1
        score = 0
        max_score = -float('inf')
        ans = 0
        for i, b in enumerate(bad):
            score += b
            if score > max_score:
                max_score = score
                ans = i
        return ans