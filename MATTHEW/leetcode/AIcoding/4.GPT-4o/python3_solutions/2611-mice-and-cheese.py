def miceAndCheese(mouse: List[int], cheese: List[int], k: int) -> int:
    return sum(sorted(cheese)[k:]) + sum(sorted(mouse, reverse=True)[:k])