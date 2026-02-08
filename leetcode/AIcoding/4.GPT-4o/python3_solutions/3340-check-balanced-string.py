def checkBalancedString(s: str) -> bool:
    count = 0
    for char in s:
        if char == 'L':
            count += 1
        elif char == 'R':
            count -= 1
        elif char == 'X':
            continue
    return count == 0