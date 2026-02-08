func findKthNumber(n int, k int) int {
    // Helper function to count how many numbers in the lexicographical tree
    // starting with `prefix` are less than or equal to `n`.
    count := func(n int, prefix int) int {
        cnt := 0
        first := prefix