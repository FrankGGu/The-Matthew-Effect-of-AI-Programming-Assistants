func stockManagement(stock []int) int {
    left, right := 0, len(stock)-1
    for left < right {
        mid := left + (right-left)/2
        if stock[mid] < stock[right] {
            right = mid
        } else if stock[mid] > stock[right] {
            left = mid + 1
        } else {
            right--
        }
    }
    return stock[left]
}