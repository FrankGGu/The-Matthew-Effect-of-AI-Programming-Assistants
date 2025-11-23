package main

func brokenCalc(target int, startValue int) int {
    res := 0
    for startValue < target {
        if target%2 == 1 {
            target++
        } else {
            target /= 2
        }
        res++
    }
    return res + startValue - target
}