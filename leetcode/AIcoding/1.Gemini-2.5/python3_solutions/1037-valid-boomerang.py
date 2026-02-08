class Solution:
    def isBoomerang(self, points: list[list[int]]) -> bool:
        x1, y1 = points[0]
        x2, y2 = points[1]
        x3, y3 = points[2]

        # Three points are a boomerang if they are distinct and not collinear.
        # This can be checked by verifying that the area of the triangle formed by them is not zero.
        # The area is non-zero if and only if the expression x1(y2 - y3) + x2(y3 - y1) + x3(y1 - y2) is not zero.
        # This expression is also zero if any two points are identical, thus implicitly handling the distinctness requirement.
        return (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) != 0