class FoodRatings:

    def __init__(self, foods: List[str], cuisines: List[str], ratings: List[int]):
        self.foods = foods
        self.cuisines = cuisines
        self.ratings = ratings
        self.food_map = {food: (cuisine, rating) for food, cuisine, rating in zip(foods, cuisines, ratings)}
        self.cuisine_map = defaultdict(list)
        for food, (cuisine, rating) in self.food_map.items():
            self.cuisine_map[cuisine].append((rating, food))

        for cuisine in self.cuisine_map:
            self.cuisine_map[cuisine].sort(reverse=True)

    def changeRating(self, food: str, newRating: int) -> None:
        cuisine, oldRating = self.food_map[food]
        self.food_map[food] = (cuisine, newRating)

        self.cuisine_map[cuisine].remove((oldRating, food))
        self.cuisine_map[cuisine].append((newRating, food))
        self.cuisine_map[cuisine].sort(reverse=True)

    def highestRated(self, cuisine: str) -> str:
        return self.cuisine_map[cuisine][0][1]