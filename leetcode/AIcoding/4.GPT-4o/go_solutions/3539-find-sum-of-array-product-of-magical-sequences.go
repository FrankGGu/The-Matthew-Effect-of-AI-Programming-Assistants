func magicalSum(arr []int) int {
    n := len(arr)
    total := 0
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            product := 1
            for k := i; k <= j; k++ {
                product *= arr[k]
            }
            total += product
        }
    }
    return total
}