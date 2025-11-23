func numOfBurgers(tomatoSlices int, cheeseSlices int) []int {
    if tomatoSlices%2 != 0 || tomatoSlices < 0 || cheeseSlices < 0 || tomatoSlices/2 < cheeseSlices {
        return []int{}
    }
    big := (tomatoSlices/2 - cheeseSlices) / 2
    small := cheeseSlices - big
    return []int{big, small}
}