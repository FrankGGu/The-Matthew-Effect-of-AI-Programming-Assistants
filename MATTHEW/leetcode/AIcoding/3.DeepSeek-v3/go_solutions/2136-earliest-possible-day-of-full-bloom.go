import "sort"

func earliestFullBloom(plantTime []int, growTime []int) int {
    n := len(plantTime)
    indices := make([]int, n)
    for i := range indices {
        indices[i] = i
    }
    sort.Slice(indices, func(i, j int) bool {
        return growTime[indices[i]] > growTime[indices[j]]
    })

    res, currPlantTime := 0, 0
    for _, i := range indices {
        currPlantTime += plantTime[i]
        if currPlantTime + growTime[i] > res {
            res = currPlantTime + growTime[i]
        }
    }
    return res
}