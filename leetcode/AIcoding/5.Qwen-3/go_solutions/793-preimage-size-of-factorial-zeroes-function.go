package main

func preimageSizeFZF(x int) int {
    left, right := 0, 5*x
    for left < right {
        mid := left + (right-left)/2
        cnt := 0
        for mid > 0 {
            mid /= 5
            cnt++
        }
        if cnt < x {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return 5
}