class Solution:
    def maximumTastiness(self, price: list[int], k: int) -> int:
        price.sort()
        n = len(price)

        def check(x: int) -> bool:
            count = 1
            last_price = price[0]
            for i in range(1, n):
                if price[i] - last_price >= x:
                    count += 1
                    last_price = price[i]
            return count >= k

        low = 0
        high = price[n - 1] - price[0]
        ans = 0

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans