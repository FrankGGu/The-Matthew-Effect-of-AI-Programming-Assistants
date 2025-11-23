class Solution:
    def removeComments(self, source: list[str]) -> list[str]:
        result = []
        current_output_line_builder = []
        in_block_comment = False

        for line in source:
            i = 0
            while i < len(line):
                if in_block_comment:
                    if i + 1 < len(line) and line[i] == '*' and line[i+1] == '/':
                        in_block_comment = False
                        i += 2
                    else:
                        i += 1
                else:
                    if i + 1 < len(line) and line[i] == '/' and line[i+1] == '/':
                        break
                    elif i + 1 < len(line) and line[i] == '/' and line[i+1] == '*':
                        in_block_comment = True
                        i += 2
                    else:
                        current_output_line_builder.append(line[i])
                        i += 1

            if not in_block_comment:
                if current_output_line_builder:
                    result.append("".join(current_output_line_builder))
                    current_output_line_builder = []

        return result