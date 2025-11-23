func arrayChange(nums []int, operations [][]int) []int {
    // Create a map to store the current index of each value.
    // This allows O(1) lookup for the index of a value.
    // Since values can be up to 10^6, a hash map is appropriate.
    valToIndex := make(map[