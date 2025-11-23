class Solution:
    def numMovesStonesII(self, stones: list[int]) -> list[int]:
        stones.sort()
        s1, s2, s3 = stones[0], stones[1], stones[2]

        # Calculate maximum moves
        # The rule for moving an endpoint stone (x, y, z where x<y<z) is:
        # move x to k such that y < k < z, or move z to k such that x < k < y.
        # This means an endpoint stone must be moved into the "other" gap.
        # To maximize moves, we want to make moves that leave the largest possible number of available moves.
        # This is achieved by repeatedly moving an endpoint stone from the smaller gap into the larger gap.
        # Effectively, each move fills one empty slot in one of the gaps.
        # The maximum number of moves is limited by the size of the larger of the two initial gaps.
        # Example: [0, 1, 10]
        # gap1 (between 0 and 1) is 0. gap2 (between 1 and 10) is 8.
        # Max moves = 8. We move 0 to 2, then 1 to 3, ..., 7 to 9. (8 moves total to reach [8,9,10])
        # Example: [0, 5, 10]
        # gap1 (between 0 and 5) is 4. gap2 (between 5 and 10) is 4.
        # Max moves = 4. (e.g., move 0 to 6, then 5 to 7, then 6 to 8, then 7 to 9 to reach [8,9,10])
        max_moves = max(s2 - s1 - 1, s3 - s2 - 1)

        # Calculate minimum moves
        min_moves = 0
        if s3 - s1 == 2:
            # Stones are already consecutive (e.g., [1, 2, 3])
            min_moves = 0
        elif s3 - s1 == 3:
            # Stones can be made consecutive in 1 move (e.g., [1, 2, 4] or [1, 3, 4])
            # [1,2,4]: move 1 to 3 -> [2,3,4]
            # [1,3,4]: move 4 to 2 -> [1,2,3]
            min_moves = 1
        elif s3 - s1 == 4:
            # Stones can be made consecutive in 1 move if they are like [X, X+2, X+4] (e.g., [1, 3, 5])
            # [1,3,5]: move 1 to 4 -> [3,4,5] OR move 5 to 2 -> [1,2,3]
            if s2 - s1 == 2 and s3 - s2 == 2:
                min_moves = 1
            else:
                # Cases like [1, 2, 5] or [1, 4, 5] require 2 moves
                # [1,2,5]: move 1 to 3 -> [2,3,5]. Then move 2 to 4 -> [3,4,5]. (2 moves)
                # [1,4,5]: move 5 to 3 -> [1,3,4]. Then move 4 to 2 -> [1,2,3]. (2 moves)
                min_moves = 2
        else:
            # For any other configuration with a span > 4 (e.g., [0, 5, 10], [1, 4, 7]),
            # it will always take 2 moves.
            # Example [0, 5, 10]:
            # 1. Move 0 to 6 -> [5, 6, 10]
            # 2. Move 10 to 7 -> [5, 6, 7] (2 moves)
            min_moves = 2

        return [min_moves, max_moves]