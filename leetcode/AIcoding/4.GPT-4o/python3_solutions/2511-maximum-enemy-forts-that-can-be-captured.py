def captureForts(forts):
    max_captures = 0
    current_captures = 0
    for fort in forts:
        if fort == 1:
            max_captures = max(max_captures, current_captures)
            current_captures = 0
        elif fort == -1:
            max_captures = max(max_captures, current_captures)
            current_captures = 0
        else:
            current_captures += 1
    return max(max_captures, current_captures)