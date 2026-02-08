package main

func main() {
}

func makeKSubarraySumsEqual(arr []int, k int) int {
    n := len(arr)
    if n%k != 0 {
        return -1
    }
    m := n / k
    for i := 0; i < k; i++ {
        sum := 0
        for j := i; j < n; j += k {
            sum += arr[j]
        }
        for j := i; j < n; j += k {
            arr[j] = sum
        }
    }
    return 0
}