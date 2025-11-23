class Solution:
    def distributeCandies(self, candies: int, num_people: int) -> list[int]:
        result = [0] * num_people
        i = 0
        give = 1
        while candies > 0:
            result[i % num_people] += min(candies, give)
            candies -= give
            give += 1
            i += 1
        return result