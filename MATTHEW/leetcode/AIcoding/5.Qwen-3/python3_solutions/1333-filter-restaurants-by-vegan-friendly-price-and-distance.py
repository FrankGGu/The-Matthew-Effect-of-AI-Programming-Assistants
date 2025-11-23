class Solution:
    def filterRestaurants(self, restaurants: List[List[int]], veganFriendly: int, maxPrice: int, maxDistance: int) -> List[List[int]]:
        result = []
        for r in restaurants:
            if veganFriendly and r[2] == 0:
                continue
            if r[3] > maxPrice:
                continue
            if r[4] > maxDistance:
                continue
            result.append(r)
        return sorted(result, key=lambda x: -x[1])