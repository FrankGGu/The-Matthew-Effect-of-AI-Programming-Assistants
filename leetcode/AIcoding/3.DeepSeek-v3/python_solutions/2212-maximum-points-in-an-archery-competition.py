class Solution:
    def maximumBobPoints(self, numArrows: int, aliceArrows: List[int]) -> List[int]:
        max_points = 0
        best_bob = [0] * 12

        def backtrack(index, remaining_arrows, current_points, bob_arrows):
            nonlocal max_points, best_bob
            if index == 12 or remaining_arrows == 0:
                if current_points > max_points:
                    max_points = current_points
                    best_bob = bob_arrows.copy()
                    if remaining_arrows > 0:
                        best_bob[0] += remaining_arrows
                return

            # Option 1: Bob doesn't win this section
            backtrack(index + 1, remaining_arrows, current_points, bob_arrows)

            # Option 2: Bob wins this section
            arrows_needed = aliceArrows[index] + 1
            if remaining_arrows >= arrows_needed:
                bob_arrows[index] = arrows_needed
                backtrack(index + 1, remaining_arrows - arrows_needed, current_points + index, bob_arrows)
                bob_arrows[index] = 0

        backtrack(0, numArrows, 0, [0] * 12)
        return best_bob