def minBoxes(n: int) -> int:
    boxes = 0
    sum_apples = 0
    while sum_apples < n:
        boxes += 1
        sum_apples += boxes
    return boxes