class Solution:
    def outerTrees(self, trees: list[list[int]]) -> list[list[int]]:
        def cross_product(p1, p2, p3):
            return (p2[0] - p1[0]) * (p3[1] - p1[1]) - (p2[1] - p1[1]) * (p3[0] - p1[0])

        trees.sort()
        n = len(trees)
        if n <= 2:
            return trees

        upper_hull = []
        for p in trees:
            while len(upper_hull) >= 2 and cross_product(upper_hull[-2], upper_hull[-1], p) < 0:
                upper_hull.pop()
            upper_hull.append(p)

        lower_hull = []
        for p in reversed(trees):
            while len(lower_hull) >= 2 and cross_product(lower_hull[-2], lower_hull[-1], p) < 0:
                lower_hull.pop()
            lower_hull.append(p)

        convex_hull = upper_hull[:-1] + lower_hull[:-1]
        return sorted(list(set(tuple(p) for p in convex_hull)))