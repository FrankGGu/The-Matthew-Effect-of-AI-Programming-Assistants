func relativeSortArray(arr1 []int, arr2 []int) []int {
    rank := make(map[int]int)
    for i, num := range arr2 {
        rank[num] = i
    }
    sort.Slice(arr1, func(i, j int) bool {
        x, y := arr1[i], arr1[j]
        rankX, hasX := rank[x]
        rankY, hasY := rank[y]
        if hasX && hasY {
            return rankX < rankY
        } else if hasX {
            return true
        } else if hasY {
            return false
        } else {
            return x < y
        }
    })
    return arr1
}