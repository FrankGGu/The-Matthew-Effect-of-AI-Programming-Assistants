class Solution:
    def maximumBeauty(self, items: List[List[int]], queries: List[int]) -> List[int]:
        items.sort()
        max_beauty = 0
        max_beauties = []
        price_list = []

        for price, beauty in items:
            max_beauty = max(max_beauty, beauty)
            max_beauties.append(max_beauty)
            price_list.append(price)

        res = []
        for q in queries:
            left, right = 0, len(price_list) - 1
            best = 0
            while left <= right:
                mid = (left + right) // 2
                if price_list[mid] <= q:
                    best = max_beauties[mid]
                    left = mid + 1
                else:
                    right = mid - 1
            res.append(best)

        return res