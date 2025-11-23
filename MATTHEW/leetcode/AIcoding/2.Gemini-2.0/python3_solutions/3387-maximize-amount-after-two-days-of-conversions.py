def maximizeAmount(amount: int, conversions: list[list[int]]) -> int:
    conversions.sort(key=lambda x: abs(x[0] - x[1]), reverse=True)

    diff = 0
    for conv in conversions:
        if conv[0] > conv[1] and amount > 0:
            diff += conv[0] - conv[1]
            amount -= 1
        elif conv[1] > conv[0] and amount < 0:
            diff += conv[1] - conv[0]
            amount += 1

    return diff