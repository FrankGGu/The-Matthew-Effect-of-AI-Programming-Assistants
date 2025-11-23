class Solution:
    def gridIllumination(self, N: int, lamps: List[List[int]], queries: List[List[int]]) -> List[int]:
        lamp_set = set()
        row_count = defaultdict(int)
        col_count = defaultdict(int)
        diag1_count = defaultdict(int)
        diag2_count = defaultdict(int)

        for r, c in lamps:
            if (r, c) not in lamp_set:
                lamp_set.add((r, c))
                row_count[r] += 1
                col_count[c] += 1
                diag1_count[r - c] += 1
                diag2_count[r + c] += 1

        result = []
        for r, c in queries:
            if (row_count[r] > 0 or col_count[c] > 0 or diag1_count[r - c] > 0 or diag2_count[r + c] > 0):
                result.append(1)
            else:
                result.append(0)
            for dr in range(-1, 2):
                for dc in range(-1, 2):
                    if (r + dr, c + dc) in lamp_set:
                        lamp_set.remove((r + dr, c + dc))
                        row_count[r + dr] -= 1
                        col_count[c + dc] -= 1
                        diag1_count[r + dr - (c + dc)] -= 1
                        diag2_count[r + dr + (c + dc)] -= 1

        return result