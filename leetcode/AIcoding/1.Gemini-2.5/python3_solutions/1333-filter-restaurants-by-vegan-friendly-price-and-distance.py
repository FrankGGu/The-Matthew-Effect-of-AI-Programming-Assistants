class Solution:
    def filterRestaurants(self, restaurants: list[list[int]], veganFriendly: int, maxPrice: int, maxDistance: int) -> list[int]:

        filtered_restaurants = []
        for restaurant in restaurants:
            rid, rating, is_vegan_friendly, price, distance = restaurant

            if veganFriendly == 1 and is_vegan_friendly == 0:
                continue

            if price > maxPrice:
                continue

            if distance > maxDistance:
                continue

            filtered_restaurants.append(restaurant)

        filtered_restaurants.sort(key=lambda x: (-x[1], -x[0]))

        return [restaurant[0] for restaurant in filtered_restaurants]