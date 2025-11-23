def distributeMoney(money: int, children: int) -> int:
    max_children = min(children, money // 3)
    money -= max_children * 3
    return max_children + (money // 2)