package main

func minSpeedOnTime(arr []int, t int) int {
    if len(arr) == 0 {
        return 0
    }
    left := 1
    right := 1e6
    ans := -1
    for left <= right {
        mid := (left + right) / 2
        time := 0.0
        for _, d := range arr {
            time += math.Ceil(float64(d)/float64(mid))
        }
        if time <= float64(t) {
            ans = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return ans
}