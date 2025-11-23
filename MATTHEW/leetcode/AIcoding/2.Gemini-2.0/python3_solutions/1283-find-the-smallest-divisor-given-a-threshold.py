class Solution:
    def smallestDivisor(self, nums: List[int], threshold: int) -> int:
        l, r = 1, max(nums)
        ans = r

        while l <= r:
            mid = (l + r) // 2
            total = sum((num + mid - 1) // mid for num in nums)

            if total <= threshold:
                ans = mid
                r = mid - 1
            else:
                l = mid + 1

        return ans