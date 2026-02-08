class Solution:
    def outerTrees(self, trees: list[list[int]]) -> list[list[int]]:
        n = len(trees)
        if n <= 2:
            return trees

        # Cross product to determine orientation
        # > 0: Counter-clockwise (left turn)
        # < 0: Clockwise (right turn)
        # = 0: Collinear
        def cross_product(p1, p2, p3):
            return (p2[0] - p1[0]) * (p3[1] - p1[1]) - (p2[1] - p1[1]) * (p3[0] - p1[0])

        # Sort points by x-coordinate, then by y-coordinate
        trees.sort()

        lower = []
        for p in trees:
            while len(lower) >= 2 and cross_product(lower[-2], lower[-1], p) < 0:
                lower.pop()
            lower.append(p)

        upper = []
        for p in reversed(trees):
            while len(upper) >= 2 and cross_product(upper[-2], upper[-1], p) < 0:
                upper.pop()
            upper.append(p)

        # Combine hulls and remove duplicates using a set
        # Convert lists to tuples for set hashing
        hull_set = set(tuple(p) for p in lower)
        for p in upper:
            hull_set.add(tuple(p))

        # Convert back to list of lists
        return [list(p) for p in hull_set]