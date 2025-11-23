class Solution:
    def triangleType(self, x: int, y: int, z: int) -> str:
        if x + y <= z or x + z <= y or y + z <= x:
            return "Invalid"
        elif x == y and y == z:
            return "Equilateral"
        elif x == y or y == z or x == z:
            return "Isosceles"
        else:
            return "Scalene"