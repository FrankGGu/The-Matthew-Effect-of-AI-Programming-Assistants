from collections import defaultdict
import heapq

class FoodRatings:
    def __init__(self, foods: list[str], cuisines: list[str], ratings: list[int]):
        self.food_to_cuisine = {}
        self.food_to_rating = {}
        self.cuisine_to_ratings = defaultdict(list)

        for i in range(len(foods)):
            food = foods[i]
            cuisine = cuisines[i]
            rating = ratings[i]
            self.food_to_cuisine[food] = cuisine
            self.food_to_rating[food] = rating
            heapq.heappush(self.cuisine_to_ratings[cuisine], (-rating, food))

    def changeRating(self, food: str, newRating: int) -> None:
        cuisine = self.food_to_cuisine[food]
        self.food_to_rating[food] = newRating
        heapq.heappush(self.cuisine_to_ratings[cuisine], (-newRating, food))

    def highestRated(self, cuisine: str) -> str:
        while self.cuisine_to_ratings[cuisine]:
            rating, food = self.cuisine_to_ratings[cuisine][0]
            if self.food_to_rating[food] == -rating:
                return food
            else:
                heapq.heappop(self.cuisine_to_ratings[cuisine])
        return ""