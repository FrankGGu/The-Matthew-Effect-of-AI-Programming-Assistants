class Solution:
    def determineTheWinner(self, player1: list[int], player2: list[int]) -> int:
        def calculate_score(player_arr: list[int]) -> int:
            score = 0
            n = len(player_arr)
            for i in range(n):
                current_pins = player_arr[i]
                multiplier = 1

                # Check if the previous frame (i-1) was a strike (10 pins)
                if i > 0 and player_arr[i-1] == 10:
                    multiplier = 2

                # Check if the frame before the previous one (i-2) was a strike (10 pins)
                # If both i-1 and i-2 were strikes, the multiplier remains 2 (not 4)
                if i > 1 and player_arr[i-2] == 10:
                    multiplier = 2

                score += current_pins * multiplier
            return score

        score1 = calculate_score(player1)
        score2 = calculate_score(player2)

        if score1 > score2:
            return 1
        elif score2 > score1:
            return 2
        else:
            return 0