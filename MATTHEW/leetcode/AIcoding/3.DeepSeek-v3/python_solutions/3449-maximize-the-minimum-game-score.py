class Solution:
    def maximizeMin(self, n: int, k: int, nums: List[int]) -> int:
        left = min(nums)
        right = sum(nums)

        def is_possible(target):
            total = 0
            count = 0
            for num in nums:
                total += num
                if total >= target:
                    count += 1
                    total = 0
                    if count >= k:
                        return True
            return False

        res = left
        while left <= right:
            mid = (left + right) // 2
            if is_possible(mid):
                res = mid
                left = mid + 1
            else:
                right = mid - 1
        return res