import "sort"

func threeSum(nums []int) [][]int {
    sort.Ints(nums) // Sort the array to efficiently find triplets and handle duplicates

    result := [][]int{}
    n := len(nums)

    // Iterate through the array with 'i' as the first element of the triplet