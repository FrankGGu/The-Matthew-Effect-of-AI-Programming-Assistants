class Solution:
    def canBeExtracted(self, n: int, artifacts: list[list[int]], digs: list[list[int]]) -> int:

        dug_cells = set()
        for r, c in digs:
            dug_cells.add((r, c))

        extractable_count = 0

        for r1, c1, r2, c2 in artifacts:
            is_extractable = True
            for r in range(r1, r2 + 1):
                for c in range(c1, c2 + 1):
                    if (r, c) not in dug_cells:
                        is_extractable = False
                        break
                if not is_extractable:
                    break

            if is_extractable:
                extractable_count += 1

        return extractable_count