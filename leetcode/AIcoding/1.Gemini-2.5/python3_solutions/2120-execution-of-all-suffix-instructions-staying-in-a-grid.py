class Solution:
    def executeInstructions(self, n: int, startPos: list[int], s: str) -> list[int]:

        results = []

        for i in range(len(s)):
            current_row, current_col = startPos[0], startPos[1]
            executed_count = 0

            for j in range(i, len(s)):
                instruction = s[j]

                if instruction == 'L':
                    current_col -= 1
                elif instruction == 'R':
                    current_col += 1
                elif instruction == 'U':
                    current_row -= 1
                elif instruction == 'D':
                    current_row += 1

                if 0 <= current_row < n and 0 <= current_col < n:
                    executed_count += 1
                else:
                    break

            results.append(executed_count)

        return results