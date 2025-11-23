class Solution:
    def minWastedSpace(self, packages: List[int], boxes: List[List[int]]) -> int:
        packages.sort()
        total = sum(packages)
        min_waste = float('inf')

        for box in boxes:
            box.sort()
            if box[-1] < packages[-1]:
                continue

            waste = 0
            j = 0

            for b in box:
                current_waste = 0
                while j < len(packages) and packages[j] <= b:
                    current_waste += packages[j]
                    j += 1
                waste += b * (j - (0 if j == 0 else len(packages) - j))

            waste = waste - total
            min_waste = min(min_waste, waste)

        return min_waste if min_waste != float('inf') else -1