func maxProfit(inventory []int, orders int) int {
    const mod = 1e9 + 7
    sort.Sort(sort.Reverse(sort.IntSlice(inventory)))
    inventory = append(inventory, 0)
    res := 0
    k := 1
    for i := 0; i < len(inventory)-1 && orders > 0; i++ {
        if inventory[i] > inventory[i+1] {
            if k*(inventory[i]-inventory[i+1]) <= orders {
                res += k * (inventory[i] + inventory[i+1] + 1) * (inventory[i] - inventory[i+1]) / 2
                orders -= k * (inventory[i] - inventory[i+1])
            } else {
                q := orders / k
                res += k * (inventory[i] + inventory[i] - q + 1) * q / 2
                remaining := orders % k
                res += remaining * (inventory[i] - q)
                orders = 0
            }
            res %= mod
        }
        k++
    }
    return res
}