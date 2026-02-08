def minimumPartition(s: str, k: int) -> int:
    n = len(s)
    count = 0
    current_value = 0

    for i in range(n):
        digit = int(s[i])
        if current_value * 10 + digit > k:
            count += 1
            current_value = digit
            if current_value > k:
                return -1
        else:
            current_value = current_value * 10 + digit

    return count + (1 if current_value > 0 else 0)