class Solution:
    def maximumTastiness(self, price: list[int], k: int) -> int:
        price.sort()

        def count_pairs(tastiness):
            count = 1
            prev = price[0]
            for i in range(1, len(price)):
                if price[i] - prev >= tastiness:
                    count += 1
                    prev = price[i]
            return count

        left, right = 0, price[-1] - price[0]
        ans = 0
        while left <= right:
            mid = (left + right) // 2
            if count_pairs(mid) >= k:
                ans = mid
                left = mid + 1
            else:
                right = mid - 1
        return ans