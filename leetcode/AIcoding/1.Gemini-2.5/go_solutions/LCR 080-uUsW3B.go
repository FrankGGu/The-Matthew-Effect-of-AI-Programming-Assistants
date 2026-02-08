func combine(n int, k int) [][]int {
    var result [][]int
    var currentCombination []int

    var backtrack func(start int)
    backtrack = func(start int) {
        if len(currentCombination) == k {
            temp := make([]int, k)
            copy(temp, currentCombination)
            result = append(result, temp)
            return
        }

        // Optimization: if remaining elements are not enough to form a combination of size k
        // n - i + 1 is the number of remaining elements from i to n
        // k - len(currentCombination) is the number of elements still needed
        // if (n - i + 1) < (k - len(currentCombination)), then break
        for i := start; i <= n && (n - i + 1) >= (k - len(currentCombination)); i++ {
            currentCombination = append(currentCombination, i)
            backtrack(i + 1)
            currentCombination = currentCombination[:len(currentCombination)-1]
        }
    }

    backtrack(1)
    return result
}