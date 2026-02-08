import "sort"

func maximumTastiness(price []int, k int) int {
    sort.Ints(price)
    left, right := 0, price[len(price)-1]-price[0]
    for left < right {
        mid := (left + right + 1) / 2
        if check(price, k, mid) {
            left = mid
        } else {
            right = mid - 1
        }
    }
    return left
}

func check(price []int, k int, tastiness int) bool {
    prev := price[0]
    count := 1
    for i := 1; i < len(price); i++ {
        if price[i] - prev >= tastiness {
            count++
            prev = price[i]
            if count >= k {
                return true
            }
        }
    }
    return count >= k
}