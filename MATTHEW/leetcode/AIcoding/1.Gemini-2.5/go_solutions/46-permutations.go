func permute(nums []int) [][]int {
    var result [][]int
    n := len(nums)
    if n == 0 {
        return result
    }

    currentPermutation := make([]int, 0, n)
    used := make([]bool, n) // To keep track of used numbers by their index in nums

    var backtrack func()
    backtrack = func() {
        // Base case: A full permutation has been formed
        if len(currentPermutation) == n {
            // Make a copy of the current permutation and add it to the result
            temp := make([]int, n)
            copy(temp, currentPermutation)
            result = append(result, temp)
            return
        }

        // Recursive step: Iterate through all available numbers
        for i := 0; i < n; i++ {
            // If the number at index i has not been used yet
            if !used[i] {
                // Choose: Mark as used and add to current permutation
                used[i] = true
                currentPermutation = append(currentPermutation, nums[i])

                // Explore: Recurse to find the next element
                backtrack()

                // Unchoose (Backtrack): Remove from current permutation and mark as unused
                currentPermutation = currentPermutation[:len(currentPermutation)-1]
                used[i] = false
            }
        }
    }

    // Start the backtracking process
    backtrack()

    return result
}