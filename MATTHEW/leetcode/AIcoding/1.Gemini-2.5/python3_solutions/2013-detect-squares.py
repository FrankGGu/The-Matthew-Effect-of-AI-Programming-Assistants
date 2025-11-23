import collections

class DetectSquares:

    def __init__(self):
        self.points_by_x = collections.defaultdict(collections.Counter)

    def add(self, point: list[int]) -> None:
        x, y = point
        self.points_by_x[x][y] += 1

    def count(self, point: list[int]) -> int:
        x1, y1 = point
        total_squares = 0

        for y_other, count_p3 in self.points_by_x[x1].items():
            if y1 == y_other:
                continue

            side_length = abs(y1 - y_other)

            x2_cand1 = x1 + side_length
            count_p4_cand1 = self.points_by_x[x2_cand1][y1]
            count_p2_cand1 = self.points_by_x[x2_cand1][y_other]

            total_squares += count_p3 * count_p4_cand1 * count_p2_cand1

            x2_cand2 = x1 - side_length
            count_p4_cand2 = self.points_by_x[x2_cand2][y1]
            count_p2_cand2 = self.points_by_x[x2_cand2][y_other]

            total_squares += count_p3 * count_p4_cand2 * count_p2_cand2

        return total_squares