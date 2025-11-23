class Solution:
    def distributeCandies(self, candies: int, num_people: int) -> list[int]:
        result = [0] * num_people
        current_candy_amount = 1
        person_idx = 0

        while candies > 0:
            give = min(current_candy_amount, candies)
            result[person_idx % num_people] += give
            candies -= give
            current_candy_amount += 1
            person_idx += 1

        return result