def lexicographicallySmallestString(s: str, a: int, b: int) -> str:
    n = len(s)
    visited = set()
    q = [s]
    visited.add(s)
    ans = s

    while q:
        curr = q.pop(0)
        ans = min(ans, curr)

        add_op = ""
        for i in range(n):
            digit = int(curr[i])
            if i % 2 == 1:
                digit = (digit + a) % 10
            add_op += str(digit)

        if add_op not in visited:
            visited.add(add_op)
            q.append(add_op)

        rotate_op = curr[b:] + curr[:b]
        if rotate_op not in visited:
            visited.add(rotate_op)
            q.append(rotate_op)

    return ans