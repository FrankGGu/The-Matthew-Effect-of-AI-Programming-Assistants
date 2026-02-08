class Solution:
    def intervalIntersection(self, firstList: list[list[int]], secondList: list[list[int]]) -> list[list[int]]:
        result = []
        i, j = 0, 0

        while i < len(firstList) and j < len(secondList):
            # Let's find the intersection of firstList[i] and secondList[j]

            # low - the maximum of the two start points
            low = max(firstList[i][0], secondList[j][0])
            # high - the minimum of the two end points
            high = min(firstList[i][1], secondList[j][1])

            # If an intersection exists (low <= high), add it to the result
            if low <= high:
                result.append([low, high])

            # Advance the pointer for the interval that ends first
            # This is because the interval that ends first cannot possibly intersect
            # with any further intervals from the other list (due to sorted and disjoint properties).
            if firstList[i][1] < secondList[j][1]:
                i += 1
            else:
                j += 1

        return result