class Solution:
    def findRestaurant(self, list1: list[str], list2: list[str]) -> list[str]:
        index_sum = float('inf')
        result = []
        for i, restaurant1 in enumerate(list1):
            if restaurant1 in list2:
                j = list2.index(restaurant1)
                current_sum = i + j
                if current_sum < index_sum:
                    index_sum = current_sum
                    result = [restaurant1]
                elif current_sum == index_sum:
                    result.append(restaurant1)
        return result