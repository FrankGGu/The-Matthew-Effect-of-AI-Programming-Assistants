class Solution:
    def filterRestaurants(self, restaurants: list[list[int]], veganFriendly: int, maxPrice: int, maxDistance: int) -> list[int]:
        filtered_restaurants = []
        for restaurant in restaurants:
            id, rating, vegan, price, distance = restaurant
            if (veganFriendly == 0 or vegan == veganFriendly) and price <= maxPrice and distance <= maxDistance:
                filtered_restaurants.append((rating, id))

        filtered_restaurants.sort(key=lambda x: (x[0], x[1]), reverse=True)

        result = [id for rating, id in filtered_restaurants]
        return result