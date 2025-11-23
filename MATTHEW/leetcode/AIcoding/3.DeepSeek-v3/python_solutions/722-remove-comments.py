class Solution:
    def removeComments(self, source: List[str]) -> List[str]:
        in_block = False
        res = []
        new_line = []

        for line in source:
            i = 0
            n = len(line)
            if not in_block:
                new_line = []
            while i < n:
                if not in_block and i + 1 < n and line[i] == '/' and line[i+1] == '*':
                    in_block = True
                    i += 1
                elif in_block and i + 1 < n and line[i] == '*' and line[i+1] == '/':
                    in_block = False
                    i += 1
                elif not in_block and i + 1 < n and line[i] == '/' and line[i+1] == '/':
                    break
                elif not in_block:
                    new_line.append(line[i])
                i += 1
            if not in_block and new_line:
                res.append(''.join(new_line))

        return res