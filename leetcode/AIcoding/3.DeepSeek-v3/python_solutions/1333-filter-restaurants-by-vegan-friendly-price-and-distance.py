class Solution:
    def filterRestaurants(self, restaurants: List[List[int]], veganFriendly: int, maxPrice: int, maxDistance: int) -> List[int]:
        filtered = []
        for r in restaurants:
            id_, rating, vegan, price, distance = r
            if (veganFriendly == 0 or vegan == veganFriendly) and price <= maxPrice and distance <= maxDistance:
                filtered.append((-rating, -id_))
        filtered.sort()
        return [-x[1] for x in filtered]