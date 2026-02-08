func partition(s string) [][]string {
    var result [][]string
    var currentPartition []string

    var isPalindrome func(sub string) bool
    isPalindrome = func(sub string) bool {
        left, right := 0, len(sub)-1
        for left < right {
            if sub[left] != sub[right] {
                return false
            }
            left++
            right--
        }
        return true
    }

    var backtrack func(start int)
    backtrack = func(start int) {
        // Base case: If we've reached the end of the string, a valid partition is found
        if start == len(s) {
            // Make a deep copy of currentPartition and add it to the result
            temp := make([]string, len(currentPartition))
            copy(temp, currentPartition)
            result = append(result, temp)
            return
        }

        // Iterate from the current 'start' index to the end of the