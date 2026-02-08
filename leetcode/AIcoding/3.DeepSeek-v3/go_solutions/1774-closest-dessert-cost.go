func closestCost(baseCosts []int, toppingCosts []int, target int) int {
    res := baseCosts[0]
    for _, base := range baseCosts {
        helper(base, toppingCosts, 0, target, &res)
    }
    return res
}

func helper(current int, toppingCosts []int, index int, target int, res *int) {
    if index == len(toppingCosts) {
        if abs(current - target) < abs(*res - target) {
            *res = current
        } else if abs(current - target) == abs(*res - target) && current < *res {
            *res = current
        }
        return
    }
    for i := 0; i <= 2; i++ {
        helper(current + i*toppingCosts[index], toppingCosts, index+1, target, res)
    }
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}