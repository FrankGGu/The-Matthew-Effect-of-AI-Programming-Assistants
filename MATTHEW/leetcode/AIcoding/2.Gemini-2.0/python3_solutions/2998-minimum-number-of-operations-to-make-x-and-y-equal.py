def minOperations(x: int, y: int) -> int:
    if x <= y:
        return y - x

    q = [(x, 0)]
    visited = {x}

    while q:
        curr, steps = q.pop(0)

        if curr == y:
            return steps

        if curr > 0 and curr not in visited:
            visited.add(curr)

            q.append((curr - 1, steps + 1))

        if curr < 2 * y and curr not in visited:
            visited.add(curr)

        if curr % 5 == 0:
            if curr // 5 not in visited:
                visited.add(curr // 5)
                q.append((curr // 5, steps + 1))
            if curr + 5 not in visited:
                visited.add(curr + 5)
                q.append((curr + 5, steps + 1))
        elif curr % 11 == 0:
            if curr // 11 not in visited:
                visited.add(curr // 11)
                q.append((curr // 11, steps + 1))
            if curr + 11 not in visited:
                visited.add(curr + 11)
                q.append((curr + 11, steps + 1))
        else:
            if curr + 1 not in visited and curr + 1 <= 2 * y:
                visited.add(curr + 1)
                q.append((curr + 1, steps + 1))

    return -1