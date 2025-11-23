from typing import List

class Solution:
    def maximumCandies(self, candies: List[int], k: int) -> int:
        total_candies = sum(candies)
        if total_candies < k:
            return 0

        left, right = 1, total_candies // k

        while left <= right:
            mid = left + (right - left) // 2

            count = 0
            for candy in candies:
                count += candy // mid

            if count >= k:
                left = mid + 1
            else:
                right = mid - 1

        return right