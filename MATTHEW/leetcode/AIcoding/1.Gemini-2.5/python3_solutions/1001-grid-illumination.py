from collections import defaultdict

class Solution:
    def gridIllumination(self, n: int, lamps: list[list[int]], queries: list[list[int]]) -> list[int]:

        active_lamps = set()

        row_counts = defaultdict(int)
        col_counts = defaultdict(int)
        diag1_counts = defaultdict(int) # r - c
        diag2_counts = defaultdict(int) # r + c

        for r, c in lamps:
            if (r, c) not in active_lamps:
                active_lamps.add((r, c))
                row_counts[r] += 1
                col_counts[c] += 1
                diag1_counts[r - c] += 1
                diag2_counts[r + c] += 1

        results = []

        neighbors = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1), (0, 0), (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]

        for qr, qc in queries:
            is_illuminated = False
            if row_counts[qr] > 0:
                is_illuminated = True
            elif col_counts[qc] > 0:
                is_illuminated = True
            elif diag1_counts[qr - qc] > 0:
                is_illuminated = True
            elif diag2_counts[qr + qc] > 0:
                is_illuminated = True

            results.append(1 if is_illuminated else 0)

            for dr, dc in neighbors:
                nr, nc = qr + dr, qc + dc

                if 0 <= nr < n and 0 <= nc < n and (nr, nc) in active_lamps:
                    active_lamps.remove((nr, nc))
                    row_counts[nr] -= 1
                    col_counts[nc] -= 1
                    diag1_counts[nr - nc] -= 1
                    diag2_counts[nr + nc] -= 1

        return results