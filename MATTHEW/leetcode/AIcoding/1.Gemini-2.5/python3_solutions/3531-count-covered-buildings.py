class Solution:
    def countCoveredBuildings(self, buildings: list[list[int]]) -> int:
        n = len(buildings)
        covered_count = 0

        for i in range(n):
            is_covered = False
            for j in range(n):
                if i == j:
                    continue

                # Check if building j covers building i
                # Building j covers building i if:
                # j's x1 <= i's x1
                # j's y1 <= i's y1
                # j's x2 >= i's x2
                # j's y2 >= i's y2
                if (buildings[j][0] <= buildings[i][0] and
                    buildings[j][1] <= buildings[i][1] and
                    buildings[j][2] >= buildings[i][2] and
                    buildings[j][3] >= buildings[i][3]):
                    is_covered = True
                    break 

            if is_covered:
                covered_count += 1

        return covered_count