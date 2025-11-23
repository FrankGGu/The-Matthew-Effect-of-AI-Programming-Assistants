func getNandResult(k int, arr []int, operations [][]int) int {
    for _, op := range operations {
        x, y := op[0], op[1]
        if x == y {
            arr[x] = (arr[x] ^ (arr[x] & arr[y])) & ((1 << k) - 1)
        } else {
            tmp := (arr[x] ^ (arr[x] & arr[y])) & ((1 << k) - 1)
            arr[x] = tmp
        }
    }
    res := arr[0]
    for i := 1; i < len(arr); i++ {
        res = (res ^ (res & arr[i])) & ((1 << k) - 1)
    }
    return res
}