func numOfBurgers(tomatoSlices int, cheeseSlices int) []int {
    if tomatoSlices%2 != 0 || tomatoSlices < 2*cheeseSlices || tomatoSlices > 4*cheeseSlices {
        return []int{}
    }

    jumbo := (tomatoSlices - 2*cheeseSlices) / 2
    small := cheeseSlices - jumbo

    return []int{jumbo, small}
}