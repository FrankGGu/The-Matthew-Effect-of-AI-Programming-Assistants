class Solution:
    def maximumTastiness(self, price: List[int], k: int) -> int:
        price.sort()

        def can_allocate(mid):
            count, last = 1, price[0]
            for p in price[1:]:
                if p - last >= mid:
                    count += 1
                    last = p
                if count >= k:
                    return True
            return count >= k

        left, right = 0, price[-1] - price[0]
        while left < right:
            mid = (left + right + 1) // 2
            if can_allocate(mid):
                left = mid
            else:
                right = mid - 1
        return left