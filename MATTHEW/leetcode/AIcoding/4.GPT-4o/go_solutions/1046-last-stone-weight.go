import "sort"

func lastStoneWeight(stones []int) int {
    if len(stones) == 0 {
        return 0
    }

    sort.Sort(sort.Reverse(sort.IntSlice(stones)))

    for len(stones) > 1 {
        y := stones[0]
        stones = stones[1:]
        x := stones[0]
        stones = stones[1:]

        if y != x {
            stones = append(stones, y-x)
            sort.Sort(sort.Reverse(sort.IntSlice(stones)))
        }
    }

    if len(stones) == 0 {
        return 0
    }

    return stones[0]
}