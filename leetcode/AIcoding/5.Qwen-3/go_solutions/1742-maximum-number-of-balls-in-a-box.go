package main

func maxBallsInBox(boxes []int) int {
    count := make(map[int]int)
    maxBalls := 0
    for _, box := range boxes {
        sum := 0
        temp := box
        for temp > 0 {
            sum += temp % 10
            temp /= 10
        }
        count[sum]++
        if count[sum] > maxBalls {
            maxBalls = count[sum]
        }
    }
    return maxBalls
}