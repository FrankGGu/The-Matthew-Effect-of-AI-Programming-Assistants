import math

class Solution:
    def buildingBoxes(self, n: int) -> int:
        k = 0
        total_boxes_in_pyramid = 0

        # Find the smallest k such that a pyramid of side length k can store at least n boxes.
        # The total number of boxes in a pyramid of side length k is V(k) = k * (k + 1) * (k + 2) / 6.
        while total_boxes_in_pyramid < n:
            k += 1
            total_boxes_in_pyramid = k * (k + 1) * (k + 2) // 6

        # The number of floor boxes required for a pyramid of side length k is F(k) = k * (k + 1) / 2.
        return k * (k + 1) // 2