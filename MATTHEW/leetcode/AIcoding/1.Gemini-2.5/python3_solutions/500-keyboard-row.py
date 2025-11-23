class Solution:
    def findWords(self, words: list[str]) -> list[str]:
        row1 = set("qwertyuiop")
        row2 = set("asdfghjkl")
        row3 = set("zxcvbnm")

        rows = [row1, row2, row3]
        result = []

        for word in words:
            lower_word = word.lower()
            if not lower_word:
                continue

            first_char = lower_word[0]
            target_row_index = -1

            if first_char in row1:
                target_row_index = 0
            elif first_char in row2:
                target_row_index = 1
            elif first_char in row3:
                target_row_index = 2

            is_single_row = True
            if target_row_index != -1:
                target_row = rows[target_row_index]
                for char in lower_word:
                    if char not in target_row:
                        is_single_row = False
                        break
            else:
                # This case should ideally not be hit if words only contain alphabet characters
                # and all alphabet characters are in one of the three rows.
                is_single_row = False 

            if is_single_row:
                result.append(word)

        return result