package main

func isPossible(arr []int, n int, d int) bool {
    for i := 1; i < n; i++ {
        if arr[i] - arr[i-1] > d {
            return false
        }
    }
    return true
}

func minimizeMax(arr []int, k int) int {
    sort.Ints(arr)
    left, right := 0, arr[len(arr)-1]-arr[0]
    var answer int
    for left <= right {
        mid := (left + right) / 2
        if isPossible(arr, len(arr), mid) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return answer
}