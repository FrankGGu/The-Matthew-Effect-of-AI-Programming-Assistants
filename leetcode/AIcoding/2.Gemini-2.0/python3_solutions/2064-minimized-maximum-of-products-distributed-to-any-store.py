def minimizedMaximum(n: int, quantities: list[int]) -> int:
    left, right = 1, max(quantities)
    while left < right:
        mid = (left + right) // 2
        count = 0
        for quantity in quantities:
            count += (quantity + mid - 1) // mid
        if count <= n:
            right = mid
        else:
            left = mid + 1
    return left