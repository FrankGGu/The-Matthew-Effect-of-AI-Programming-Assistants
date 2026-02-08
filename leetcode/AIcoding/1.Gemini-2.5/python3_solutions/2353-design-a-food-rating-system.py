import heapq
from collections import defaultdict

class FoodRatings:

    def __init__(self, foods: list[str], cuisines: list[str], ratings: list[int]):
        self.food_info = {}  # food_name -> (cuisine, rating)
        self.cuisine_to_foods = defaultdict(list) # cuisine -> min-heap of (-rating, food_name)

        for i in range(len(foods)):
            food = foods[i]
            cuisine = cuisines[i]
            rating = ratings[i]

            self.food_info[food] = (cuisine, rating)
            heapq.heappush(self.cuisine_to_foods[cuisine], (-rating, food))

    def changeRating(self, food: str, newRating: int) -> None:
        cuisine, _ = self.food_info[food]
        self.food_info[food] = (cuisine, newRating)
        # Push the new rating to the heap. Old entries will be lazily removed in highestRated.
        heapq.heappush(self.cuisine_to_foods[cuisine], (-newRating, food))

    def highestRated(self, cuisine: str) -> str:
        while True:
            # Peek at the top of the heap
            neg_rating, food_name = self.cuisine_to_foods[cuisine][0]
            current_cuisine, current_rating = self.food_info[food_name]

            # Check if the rating in the heap matches the current rating of the food
            if -neg_rating == current_rating:
                return food_name
            else:
                # This is a stale entry, pop it and continue
                heapq.heappop(self.cuisine_to_foods[cuisine])