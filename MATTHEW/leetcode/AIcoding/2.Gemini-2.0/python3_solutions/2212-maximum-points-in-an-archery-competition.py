class Solution:
    def maximumBobPoints(self, numArrows: int, aliceArrows: list[int]) -> list[int]:
        n = len(aliceArrows)
        max_points = -1
        best_bob = []

        for mask in range(1 << n):
            arrows_used = 0
            points = 0
            bob_arrows = [0] * n

            for i in range(n):
                if (mask >> i) & 1:
                    arrows_needed = aliceArrows[i] + 1
                    if arrows_used + arrows_needed <= numArrows:
                        arrows_used += arrows_needed
                        points += i
                        bob_arrows[i] = arrows_needed
                    else:
                        points = -1
                        break

            if points > max_points:
                max_points = points
                best_bob = bob_arrows[:]
                best_bob[0] += numArrows - arrows_used
            elif points == max_points and points != -1:
                temp_bob = bob_arrows[:]
                temp_bob[0] += numArrows - arrows_used
                if sum(temp_bob) > sum(best_bob):
                    best_bob = temp_bob[:]

        return best_bob