import "sort"

func reductionOperations(nums []int) int {
    sort.Ints(nums)

    operations := 0
    currentSteps := 0 // Represents how many "reduction levels" the current distinct number has to go down

    // Iterate from the second element to the end
    for i := 1; i