class Solution:
    def flipgame(self, fronts: List[int], backs: List[int]) -> int:
        same = {x for x, y in zip(fronts, backs) if x == y}
        res = float('inf')
        for num in fronts + backs:
            if num not in same:
                res = min(res, num)
        return res if res != float('inf') else 0