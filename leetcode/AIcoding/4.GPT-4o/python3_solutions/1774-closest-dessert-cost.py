def closestCost(base: List[int], topping: List[int], target: int) -> int:
    closest = float('inf')

    def dfs(current_cost, index):
        nonlocal closest
        if abs(current_cost - target) < abs(closest - target) or (abs(current_cost - target) == abs(closest - target) and current_cost < closest):
            closest = current_cost
        if index == len(topping):
            return
        for i in range(0, 3):
            dfs(current_cost + i * topping[index], index + 1)

    for b in base:
        dfs(b, 0)

    return closest