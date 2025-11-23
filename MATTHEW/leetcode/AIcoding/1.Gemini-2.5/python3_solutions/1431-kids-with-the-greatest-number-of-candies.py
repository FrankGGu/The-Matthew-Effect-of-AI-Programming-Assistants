class Solution:
    def kidsWithCandies(self, candies: list[int], extraCandies: int) -> list[bool]:
        max_candies = 0
        for candy_count in candies:
            if candy_count > max_candies:
                max_candies = candy_count

        result = []
        for candy_count in candies:
            if candy_count + extraCandies >= max_candies:
                result.append(True)
            else:
                result.append(False)

        return result