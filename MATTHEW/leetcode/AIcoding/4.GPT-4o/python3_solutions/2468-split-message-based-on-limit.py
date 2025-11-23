def splitMessage(message: str, limit: int) -> List[str]:
    parts = []
    n = len(message)
    total_length = 0
    part_num = 1

    while total_length < n:
        current_limit = limit - len(f"{part_num}/{part_num}")
        if current_limit <= 0:
            return []

        start = total_length
        end = min(start + current_limit, n)
        parts.append(message[start:end] + f"{part_num}/{len(parts) + 1}")
        total_length += end - start
        part_num += 1

    return parts