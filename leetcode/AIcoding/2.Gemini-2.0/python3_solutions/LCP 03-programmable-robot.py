class Solution:
    def isProgrammable(self, numRows: int, numCols: int, robot: List[int], target: List[int], instructions: List[List[int]]) -> bool:
        def simulate(start_row, start_col, instruction):
            row, col = start_row, start_col
            for move in instruction:
                if move == 0:
                    row -= 1
                elif move == 1:
                    col += 1
                elif move == 2:
                    row += 1
                else:
                    col -= 1

                if not (0 <= row < numRows and 0 <= col < numCols):
                    return False, -1, -1

            return True, row, col

        for i in range(1 << (2 * len(instructions))):
            instruction1 = []
            instruction2 = []
            temp = i
            for _ in range(len(instructions)):
                instruction1.append(temp % 4)
                temp //= 4

            valid1, end_row1, end_col1 = simulate(robot[0], robot[1], instruction1)

            if not valid1:
                continue

            temp = i
            for _ in range(len(instructions)):
                instruction2.append(temp % 4)
                temp //= 4
            instruction2.reverse()

            valid2, end_row2, end_col2 = simulate(end_row1, end_col1, instruction2)

            if valid2 and end_row2 == target[0] and end_col2 == target[1]:
                return True

        return False