import "sort"

func minImpossibleOR(nums []int) int {
    sort.Ints(nums)

    reachableORMax := 0
    for _, num := range nums {
        if num > reachableORMax + 1 {
            break // Found the smallest impossible OR
        }
        reachableORMax |= num