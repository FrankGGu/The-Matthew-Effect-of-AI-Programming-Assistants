class Solution:
    def findRestaurant(self, list1: list[str], list2: list[str]) -> list[str]:
        map1 = {s: i for i, s in enumerate(list1)}

        min_sum = float('inf')
        result = []

        for j, s2 in enumerate(list2):
            if s2 in map1:
                i = map1[s2]
                current_sum = i + j

                if current_sum < min_sum:
                    min_sum = current_sum
                    result = [s2]
                elif current_sum == min_sum:
                    result.append(s2)

        return result