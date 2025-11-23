class Solution:
    def findLexicographicallyLargestString(self, box: list[str]) -> str:
        num_rows = len(box)
        num_cols = len(box[0])

        result_chars = []

        for j in range(num_cols):
            max_char_in_col = 'a'
            for i in range(num_rows):
                if box[i][j] > max_char_in_col:
                    max_char_in_col = box[i][j]
            result_chars.append(max_char_in_col)

        return "".join(result_chars)