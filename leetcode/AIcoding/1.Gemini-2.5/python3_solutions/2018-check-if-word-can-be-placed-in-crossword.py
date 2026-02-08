from typing import List

class Solution:
    def placeWordInCrossword(self, board: List[List[str]], word: str) -> bool:
        m, n = len(board), len(board[0])

        def can_match(slot_str: str, target_word: str) -> bool:
            if len(slot_str) != len(target_word):
                return False

            forward_match = True
            backward_match = True

            for i in range(len(target_word)):
                if slot_str[i] != ' ' and slot_str[i] != target_word[i]:
                    forward_match = False

                if slot_str[i] != ' ' and slot_str[i] != target_word[len(target_word) - 1 - i]:
                    backward_match = False

                if not forward_match and not backward_match:
                    return False 

            return forward_match or backward_match

        for r in range(m):
            row_str = "".join(board[r])
            segments = row_str.split('#')
            for segment in segments:
                if can_match(segment, word):
                    return True

        for c in range(n):
            col_str_list = [board[r][c] for r in range(m)]
            col_str = "".join(col_str_list)

            segments = col_str.split('#')
            for segment in segments:
                if can_match(segment, word):
                    return True

        return False