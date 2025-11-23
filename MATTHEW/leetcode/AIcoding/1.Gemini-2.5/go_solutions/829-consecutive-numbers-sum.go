func consecutiveNumbersSum(n int) int {
    count := 0
    // The sum of k consecutive integers starting from x is:
    // n = x + (x+1) + ... + (x+k-1)
    // n = k*x + k*(k-1)/2
    // We need to find positive