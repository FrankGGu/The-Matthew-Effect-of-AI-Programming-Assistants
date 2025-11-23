class Solution:
    def fullJustify(self, words: List[str], maxWidth: int) -> List[str]:
        res = []
        line = []
        length = 0

        for word in words:
            if length + len(word) + len(line) > maxWidth:
                spaces = maxWidth - length
                if len(line) == 1:
                    res.append(line[0] + ' ' * spaces)
                else:
                    space_between = spaces // (len(line) - 1)
                    extra = spaces % (len(line) - 1)
                    for i in range(extra):
                        line[i] += ' '
                    res.append((' ' * space_between).join(line))
                line = []
                length = 0
            line.append(word)
            length += len(word)

        last_line = ' '.join(line)
        last_line += ' ' * (maxWidth - len(last_line))
        res.append(last_line)

        return res