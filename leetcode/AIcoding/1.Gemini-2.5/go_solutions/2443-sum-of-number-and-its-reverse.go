func sumOfNumberAndReverse(num int) bool {
    // Handle the special case for num = 0
    if num == 0 {
        return true
    }

    // Helper function to reverse an integer
    reverse := func(n int) int {
        reversedN := 0
        for n > 0