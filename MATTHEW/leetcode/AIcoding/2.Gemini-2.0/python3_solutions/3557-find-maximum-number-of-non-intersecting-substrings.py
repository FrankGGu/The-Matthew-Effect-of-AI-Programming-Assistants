def maxNonOverlapping(s: str) -> list[str]:
    first = {}
    last = {}
    for i, c in enumerate(s):
        if c not in first:
            first[c] = i
        last[c] = i
    intervals = []
    for c in set(s):
        l, r = first[c], last[c]
        valid = True
        i = l
        while i <= r:
            if first[s[i]] < l:
                valid = False
                break
            r = max(r, last[s[i]])
            i += 1
        if valid:
            intervals.append((l, r))
    intervals.sort(key=lambda x: x[1])
    res = []
    end = -1
    for l, r in intervals:
        if l > end:
            res.append(s[l:r + 1])
            end = r
    return res