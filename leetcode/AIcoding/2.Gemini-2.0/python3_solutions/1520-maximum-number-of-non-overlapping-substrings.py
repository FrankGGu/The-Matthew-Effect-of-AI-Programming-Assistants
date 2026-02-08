def maxNonOverlapping(s: str) -> list[str]:
    first = {}
    last = {}
    for i, c in enumerate(s):
        if c not in first:
            first[c] = i
        last[c] = i

    intervals = []
    for c in set(s):
        intervals.append((first[c], last[c]))

    intervals.sort()

    res = []
    end = -1
    curr_start = -1
    curr_end = float('inf')

    for start, end_val in intervals:
        if start > end:
            if curr_start != -1:
                res.append(s[curr_start:curr_end + 1])
                end = curr_end
            curr_start = start
            curr_end = end_val

            valid = True
            max_end = end_val
            for i in range(curr_start, curr_end + 1):
                if first[s[i]] < curr_start:
                    valid = False
                    break
                max_end = max(max_end, last[s[i]])
            if not valid:
                curr_start = -1
                curr_end = float('inf')
                continue

            curr_end = max_end
        else:
            valid = True
            max_end = end_val
            for i in range(start, end_val + 1):
                if first[s[i]] < curr_start:
                    valid = False
                    break
                max_end = max(max_end, last[s[i]])
            if not valid:
                continue
            curr_end = min(curr_end, max_end)

    if curr_start != -1:
        res.append(s[curr_start:curr_end + 1])

    return res