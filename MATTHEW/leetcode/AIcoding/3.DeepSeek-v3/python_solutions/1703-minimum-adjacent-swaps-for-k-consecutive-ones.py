class Solution:
    def minMoves(self, nums: List[int], k: int) -> int:
        pos = [i for i, num in enumerate(nums) if num == 1]
        n = len(pos)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + pos[i]

        res = float('inf')
        radius = (k - 1) // 2
        for i in range(n - k + 1):
            left = i
            right = i + k - 1
            mid = (left + right) // 2
            if k % 2 == 1:
                left_sum = pos[mid] * (mid - left) - (prefix[mid] - prefix[left])
                right_sum = (prefix[right + 1] - prefix[mid + 1]) - pos[mid] * (right - mid)
                total = left_sum + right_sum
            else:
                left_sum = pos[mid] * (mid - left) - (prefix[mid] - prefix[left])
                right_sum = (prefix[right + 1] - prefix[mid + 1]) - pos[mid] * (right - mid)
                total = left_sum + right_sum + (pos[mid + 1] - pos[mid] - 1) * (right - mid)
            res = min(res, total)
        return res