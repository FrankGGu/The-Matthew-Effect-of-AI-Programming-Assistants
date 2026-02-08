from collections import defaultdict

class Solution:
    def countBlackBlocks(self, m: int, n: int, coordinates: list[list[int]]) -> list[int]:
        black_cells_set = set()
        for r, c in coordinates:
            black_cells_set.add((r, c))

        block_counts = defaultdict(int)
        visited_top_lefts = set()

        for r, c in black_cells_set:
            # A black cell (r, c) can be one of the four cells in a 2x2 block.
            # We determine the top-left coordinate (tr, tc) for each of these 4 possibilities.
            # (dr, dc) represents the offset of (r, c) from the top-left (tr, tc)
            # So, tr = r - dr, tc = c - dc
            for dr in [0, 1]:
                for dc in [0, 1]:
                    tr = r - dr
                    tc = c - dc

                    # Check if (tr, tc) is a valid top-left coordinate for a 2x2 block
                    # A 2x2 block with top-left (tr, tc) exists if:
                    # tr is within [0, m-2] (inclusive)
                    # tc is within [0, n-2] (inclusive)
                    if 0 <= tr < m - 1 and 0 <= tc < n - 1:
                        if (tr, tc) not in visited_top_lefts:
                            visited_top_lefts.add((tr, tc))

                            current_black_count = 0
                            # Check the 4 cells of this 2x2 block
                            if (tr, tc) in black_cells_set:
                                current_black_count += 1
                            if (tr, tc + 1) in black_cells_set:
                                current_black_count += 1
                            if (tr + 1, tc) in black_cells_set:
                                current_black_count += 1
                            if (tr + 1, tc + 1) in black_cells_set:
                                current_black_count += 1

                            block_counts[current_black_count] += 1

        ans = [0] * 5
        total_possible_2x2_blocks = (m - 1) * (n - 1)

        for count, freq in block_counts.items():
            ans[count] = freq

        # The number of 2x2 blocks with 0 black cells is the total number of possible 2x2 blocks
        # minus the sum of 2x2 blocks that contain 1, 2, 3, or 4 black cells.
        ans[0] = total_possible_2x2_blocks - sum(ans[1:])

        return ans