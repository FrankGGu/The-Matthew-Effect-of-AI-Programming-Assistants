package main

func findRadius(houses []int, heaters []int) int {
    sort.Ints(houses)
    sort.Ints(heaters)
    res := 0
    for i, house := range houses {
        left, right := 0, len(heaters)-1
        for left < right {
            mid := (left + right) / 2
            if heaters[mid] < house {
                left = mid + 1
            } else {
                right = mid
            }
        }
        dist := abs(heaters[left] - house)
        if i == 0 || dist < res {
            res = dist
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}