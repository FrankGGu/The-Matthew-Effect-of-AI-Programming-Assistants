func minOr(nums []int, k int) int {
    n := len(nums)
    ans := 0

    // check function: determines if it's possible to achieve a final OR sum
    // where every element in the final array is a submask of `targetOrSum`,
    // using at most `k` operations