class Solution:
    def furthestDistanceFromOrigin(self, moves: str) -> int:
        count_L = 0
        count_R = 0
        count_U = 0

        for move in moves:
            if move == 'L':
                count_L += 1
            elif move == 'R':
                count_R += 1
            else:
                count_U += 1

        initial_displacement = count_R - count_L

        pos_if_all_U_right = initial_displacement + count_U
        pos_if_all_U_left = initial_displacement - count_U

        return max(abs(pos_if_all_U_right), abs(pos_if_all_U_left))