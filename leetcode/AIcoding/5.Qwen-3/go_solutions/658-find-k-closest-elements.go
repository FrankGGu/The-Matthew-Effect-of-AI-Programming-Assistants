package main

func findClosestElements(arr []int, k int, x int) []int {
    left, right := 0, len(arr)-k
    for left < right {
        mid := (left + right) / 2
        if arr[mid] < x && arr[mid+k] > x {
            left = mid + 1
        } else if arr[mid] > x {
            right = mid
        } else {
            right = mid
        }
    }
    return arr[left : left+k]
}