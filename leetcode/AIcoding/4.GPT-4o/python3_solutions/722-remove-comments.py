class Solution:
    def removeComments(self, source: List[str]) -> List[str]:
        in_block = False
        result = []
        current_line = []

        for line in source:
            i = 0
            while i < len(line):
                if in_block:
                    if line[i:i+2] == '*/':
                        in_block = False
                        i += 2
                    else:
                        i += 1
                else:
                    if line[i:i+2] == '/*':
                        in_block = True
                        i += 2
                    elif line[i:i+2] == '//':
                        break
                    else:
                        current_line.append(line[i])
                        i += 1

            if not in_block and current_line:
                result.append(''.join(current_line))
                current_line = []

        return result