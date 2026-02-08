func constructArray(n int, k int) []int {
    result := make([]int, n)
    low := 1
    high := k + 1 // The first k+1 numbers will be used to generate k distinct differences

    // Phase 1: Generate k distinct differences (k, k-1, ..., 1)
    //