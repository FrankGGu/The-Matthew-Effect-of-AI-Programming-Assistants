class FoodRatings:

    def __init__(self, foods: list[str], cuisines: list[str], ratings: list[int]):
        self.food_cuisine = {}
        self.food_rating = {}
        self.cuisine_foods = {}

        for i in range(len(foods)):
            food = foods[i]
            cuisine = cuisines[i]
            rating = ratings[i]

            self.food_cuisine[food] = cuisine
            self.food_rating[food] = rating

            if cuisine not in self.cuisine_foods:
                self.cuisine_foods[cuisine] = []

            self.cuisine_foods[cuisine].append((rating, food))

        for cuisine in self.cuisine_foods:
            self.cuisine_foods[cuisine].sort(key = lambda x: (-x[0], x[1]))

    def changeRating(self, food: str, newRating: int) -> None:
        cuisine = self.food_cuisine[food]
        self.food_rating[food] = newRating

        foods = self.cuisine_foods[cuisine]

        for i in range(len(foods)):
            if foods[i][1] == food:
                foods[i] = (newRating, food)
                break

        self.cuisine_foods[cuisine].sort(key = lambda x: (-x[0], x[1]))

    def highestRated(self, cuisine: str) -> str:
        return self.cuisine_foods[cuisine][0][1]