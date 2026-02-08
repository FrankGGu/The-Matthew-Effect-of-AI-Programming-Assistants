def canArrange(arr: List[int], k: int) -> bool:
    remainder_count = [0] * k
    for num in arr:
        remainder_count[num % k] += 1

    for i in range(1, (k // 2) + 1):
        if remainder_count[i] != remainder_count[k - i]:
            return False

    return remainder_count[0] % 2 == 0