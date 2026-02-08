class Solution:
    def maximumTastiness(self, price: List[int], k: int) -> int:
        price.sort()
        left, right = 0, price[-1] - price[0]
        answer = 0

        def can_form_basket(min_diff):
            count = 1
            last = price[0]
            for i in range(1, len(price)):
                if price[i] - last >= min_diff:
                    count += 1
                    last = price[i]
                    if count >= k:
                        return True
            return count >= k

        while left <= right:
            mid = (left + right) // 2
            if can_form_basket(mid):
                answer = mid
                left = mid + 1
            else:
                right = mid - 1
        return answer