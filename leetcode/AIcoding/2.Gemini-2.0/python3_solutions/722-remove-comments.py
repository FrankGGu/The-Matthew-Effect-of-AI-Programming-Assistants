class Solution:
    def removeComments(self, source: List[str]) -> List[str]:
        res = []
        in_block = False
        for line in source:
            i = 0
            if not in_block:
                new_line = ""
            while i < len(line):
                if in_block:
                    if line[i:i + 2] == "*/":
                        in_block = False
                        i += 2
                    else:
                        i += 1
                else:
                    if line[i:i + 2] == "/*":
                        in_block = True
                        i += 2
                    elif line[i:i + 2] == "//":
                        break
                    else:
                        new_line += line[i]
                        i += 1
            if not in_block and new_line:
                res.append(new_line)
        return res