def reachNumber(target: int) -> int:
    target = abs(target)
    step = 0
    sum_val = 0
    while sum_val < target:
        step += 1
        sum_val += step

    if (sum_val - target) % 2 == 0:
        return step
    else:
        if step % 2 == 0:
            return step + 1
        else:
            return step + 2