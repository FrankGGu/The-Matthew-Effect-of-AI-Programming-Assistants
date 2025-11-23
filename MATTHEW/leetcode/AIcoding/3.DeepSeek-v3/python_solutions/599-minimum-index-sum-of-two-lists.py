class Solution:
    def findRestaurant(self, list1: List[str], list2: List[str]) -> List[str]:
        index_map = {restaurant: i for i, restaurant in enumerate(list1)}
        min_sum = float('inf')
        result = []

        for j, restaurant in enumerate(list2):
            if restaurant in index_map:
                current_sum = index_map[restaurant] + j
                if current_sum < min_sum:
                    min_sum = current_sum
                    result = [restaurant]
                elif current_sum == min_sum:
                    result.append(restaurant)

        return result