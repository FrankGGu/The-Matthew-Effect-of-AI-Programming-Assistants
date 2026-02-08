def smallestDivisibleDigitProduct(n: int) -> int:
    if n == 1:
        return 1

    q = [(0, 1)]
    visited = {1}

    while q:
        num, prod = q.pop(0)

        if prod == n:
            return num

        for digit in range(2, 10):
            new_prod = prod * digit
            if new_prod <= n and new_prod > 0 and (new_prod not in visited):
                new_num = num * 10 + digit
                q.append((new_num, new_prod))
                visited.add(new_prod)

    return -1