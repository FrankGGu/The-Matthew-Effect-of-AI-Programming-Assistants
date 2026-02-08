class Solution:
    def maxmiumScore(self, cards: List[int], cnt: int) -> int:
        cards.sort(reverse=True)
        selected = cards[:cnt]
        total = sum(selected)
        if total % 2 == 0:
            return total
        min_odd = min_even = float('inf')
        for num in selected:
            if num % 2 == 1:
                min_odd = min(min_odd, num)
            else:
                min_even = min(min_even, num)
        max_odd = max_even = -1
        for num in cards[cnt:]:
            if num % 2 == 1 and max_even < num:
                max_even = num
            elif num % 2 == 0 and max_odd < num:
                max_odd = num
        res = 0
        if min_odd != float('inf') and max_odd != -1:
            res = max(res, total - min_odd + max_odd)
        if min_even != float('inf') and max_even != -1:
            res = max(res, total - min_even + max_even)
        return res