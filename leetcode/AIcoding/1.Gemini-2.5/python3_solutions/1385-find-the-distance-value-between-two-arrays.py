class Solution:
    def findTheDistanceValue(self, arr1: list[int], arr2: list[int], d: int) -> int:
        distance_value = 0
        for num1 in arr1:
            is_valid = True
            for num2 in arr2:
                if abs(num1 - num2) <= d:
                    is_valid = False
                    break
            if is_valid:
                distance_value += 1
        return distance_value