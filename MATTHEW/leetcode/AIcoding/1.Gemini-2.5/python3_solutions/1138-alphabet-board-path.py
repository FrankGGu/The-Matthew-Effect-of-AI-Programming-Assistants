class Solution:
    def alphabetBoardPath(self, target: str) -> str:

        def char_to_coords(char):
            idx = ord(char) - ord('a')
            return (idx // 5, idx % 5)

        current_r, current_c = 0, 0
        result = []

        for char_code in target:
            target_r, target_c = char_to_coords(char_code)

            path_segment = []

            dr = target_r - current_r
            dc = target_c - current_c

            if current_r == 5 and current_c == 0: # Currently at 'z'
                # If current is 'z', must move Up first to avoid going off-board when moving L/R
                path_segment.append('U' * abs(dr))
                if dc > 0:
                    path_segment.append('R' * dc)
                elif dc < 0:
                    path_segment.append('L' * abs(dc))
            elif target_r == 5 and target_c == 0: # Target is 'z'
                # If target is 'z', must move Left/Right first to reach column 0, then Down
                if dc > 0:
                    path_segment.append('R' * dc)
                elif dc < 0:
                    path_segment.append('L' * abs(dc))
                path_segment.append('D' * dr)
            else: # Neither current nor target is 'z'
                # Standard vertical then horizontal movement
                if dr > 0:
                    path_segment.append('D' * dr)
                elif dr < 0:
                    path_segment.append('U' * abs(dr))

                if dc > 0:
                    path_segment.append('R' * dc)
                elif dc < 0:
                    path_segment.append('L' * abs(dc))

            result.append("".join(path_segment))
            result.append("!")

            current_r, current_c = target_r, target_c

        return "".join(result)