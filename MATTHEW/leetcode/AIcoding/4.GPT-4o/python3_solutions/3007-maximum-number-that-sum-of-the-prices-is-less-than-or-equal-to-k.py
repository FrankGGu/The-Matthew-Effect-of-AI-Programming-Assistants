class Solution:
    def maxCount(self, price: List[int], k: int) -> int:
        price.sort()
        count = 0
        total = 0

        for p in price:
            if total + p <= k:
                total += p
                count += 1
            else:
                break

        return count