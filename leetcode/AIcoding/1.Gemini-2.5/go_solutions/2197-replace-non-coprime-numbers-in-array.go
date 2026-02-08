func replaceNonCoprimes(nums []int) []int {
    stack := []int{}

    for _, num := range nums {
        stack = append(stack, num) // Push current number onto the stack

        // Continuously merge if the last two elements in the stack are not coprime
        for len(stack)