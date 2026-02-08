func countOrders(n int) int {
    MOD := 1_000_000_007

    // Base case: for n=1, there's only one valid order (P1, D1).
    result := 1 

    // For each subsequent order i from