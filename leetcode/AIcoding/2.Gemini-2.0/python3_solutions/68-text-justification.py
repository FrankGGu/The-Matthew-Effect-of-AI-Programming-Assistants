def fullJustify(words, maxWidth):
    res = []
    curr_line = []
    curr_len = 0

    for word in words:
        if curr_len + len(word) + len(curr_line) > maxWidth:
            if len(curr_line) == 1:
                res.append(curr_line[0] + ' ' * (maxWidth - curr_len))
            else:
                spaces_needed = maxWidth - curr_len
                spaces_between = spaces_needed // (len(curr_line) - 1)
                extra_spaces = spaces_needed % (len(curr_line) - 1)

                line = ""
                for i in range(len(curr_line) - 1):
                    line += curr_line[i] + ' ' * (spaces_between + (1 if i < extra_spaces else 0))
                line += curr_line[-1]
                res.append(line)

            curr_line = [word]
            curr_len = len(word)
        else:
            curr_line.append(word)
            curr_len += len(word)

    last_line = ' '.join(curr_line)
    last_line += ' ' * (maxWidth - len(last_line))
    res.append(last_line)

    return res