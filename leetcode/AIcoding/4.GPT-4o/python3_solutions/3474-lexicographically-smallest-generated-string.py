def lexSmallestString(s: str, a: int, b: int) -> str:
    n = len(s)
    visited = set()
    queue = [s]
    result = s

    while queue:
        current = queue.pop(0)
        result = min(result, current)
        if current in visited:
            continue
        visited.add(current)

        # Add 'a' to each character
        modified = ''.join(chr((ord(c) - ord('a') + a) % 26 + ord('a')) for c in current)
        if modified not in visited:
            queue.append(modified)

        # Rotate string
        rotated = current[-b:] + current[:-b]
        if rotated not in visited:
            queue.append(rotated)

    return result