class Solution:
    def distributeCandies(self, candyType: list[int]) -> int:
        num_candies_to_eat = len(candyType) // 2
        unique_candy_types = len(set(candyType))
        return min(num_candies_to_eat, unique_candy_types)