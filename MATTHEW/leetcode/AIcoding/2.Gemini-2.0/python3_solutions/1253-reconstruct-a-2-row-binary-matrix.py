class Solution:
    def reconstructMatrix(self, upper: int, lower: int, colsum: list[int]) -> list[list[int]]:
        n = len(colsum)
        upper_row = [0] * n
        lower_row = [0] * n

        for i in range(n):
            if colsum[i] == 2:
                upper_row[i] = 1
                lower_row[i] = 1
                upper -= 1
                lower -= 1
            elif colsum[i] == 1:
                if upper > lower:
                    upper_row[i] = 1
                    upper -= 1
                else:
                    lower_row[i] = 1
                    lower -= 1

        if upper < 0 or lower < 0:
            return []

        if upper > 0 or lower > 0:
            return []

        total_upper = sum(upper_row)
        total_lower = sum(lower_row)

        if total_upper != sum([x for i, x in enumerate(colsum) if upper_row[i] == 1]) or total_lower != sum([x for i, x in enumerate(colsum) if lower_row[i] == 1]):
            return []

        return [upper_row, lower_row]