class Solution:
    def filterRestaurants(self, restaurants: List[List[int]], veganFriendly: int, maxPrice: int, maxDistance: int) -> List[List[int]]:
        filtered = [
            restaurant for restaurant in restaurants
            if (veganFriendly == 0 or restaurant[2] == 1) and 
               restaurant[3] <= maxPrice and 
               restaurant[4] <= maxDistance
        ]
        return sorted(filtered, key=lambda x: (-x[1], -x[0]))