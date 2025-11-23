func countTriplets(arr []int) int {
    n := len(arr)
    if n < 2 {
        return 0
    }

    // prefixXOR[i] stores the XOR sum of arr[0]...arr[i-1]
    // prefixXOR has length n+1
    prefixX