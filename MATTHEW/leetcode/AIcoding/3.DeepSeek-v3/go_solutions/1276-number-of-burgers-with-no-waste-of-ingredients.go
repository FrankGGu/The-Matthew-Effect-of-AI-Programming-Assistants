func numOfBurgers(tomatoSlices int, cheeseSlices int) []int {
    if tomatoSlices < 2 * cheeseSlices || tomatoSlices > 4 * cheeseSlices || tomatoSlices % 2 != 0 {
        return []int{}
    }
    jumbo := (tomatoSlices - 2 * cheeseSlices) / 2
    small := cheeseSlices - jumbo
    if jumbo >= 0 && small >= 0 {
        return []int{jumbo, small}
    }
    return []int{}
}