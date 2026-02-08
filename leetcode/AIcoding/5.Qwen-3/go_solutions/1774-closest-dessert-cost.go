package main

func closestCost(base_costs []int, topping_costs []int, target int) int {
    var result int
    minDiff := 1 << 31 - 1

    var dfs func(int, int)
    dfs = func(current int, index int) {
        if index == len(topping_costs) {
            diff := abs(current - target)
            if diff < minDiff || (diff == minDiff && current < result) {
                minDiff = diff
                result = current
            }
            return
        }

        dfs(current, index+1)
        for i := 0; i < 100; i++ {
            current += topping_costs[index]
            dfs(current, index+1)
        }
    }

    for _, base := range base_costs {
        dfs(base, 0)
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}