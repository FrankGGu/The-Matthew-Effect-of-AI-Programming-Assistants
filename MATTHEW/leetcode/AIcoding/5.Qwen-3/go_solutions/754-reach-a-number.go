package main

func reachNumber(target int) int {
    target = abs(target)
    var k int
    for sum := 0; sum < target; k++ {
        sum += k
    }
    for (sum-target)%2 != 0 {
        k++
        sum += k
    }
    return k
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}