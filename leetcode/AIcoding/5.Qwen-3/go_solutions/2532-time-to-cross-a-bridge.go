package main

func findCrossingTime(n int, k int, time []int) int {
    left := make([]int, k)
    right := make([]int, k)
    for i := range left {
        left[i] = i
        right[i] = i
    }

    var waitLeft, waitRight []int
    var inTransit []int

    for len(left)+len(right)+len(inTransit) > 0 {
        if len(waitLeft) > 0 {
            for i := 0; i < len(waitLeft); i++ {
                if time[waitLeft[i]] <= 0 {
                    left = append(left, waitLeft[i])
                    waitLeft = append(waitLeft[:i], waitLeft[i+1:]...)
                    i--
                } else {
                    time[waitLeft[i]]--
                }
            }
        }

        if len(waitRight) > 0 {
            for i := 0; i < len(waitRight); i++ {
                if time[waitRight[i]] <= 0 {
                    right = append(right, waitRight[i])
                    waitRight = append(waitRight[:i], waitRight[i+1:]...)
                    i--
                } else {
                    time[waitRight[i]]--
                }
            }
        }

        if len(inTransit) > 0 {
            for i := 0; i < len(inTransit); i++ {
                if time[inTransit[i]] <= 0 {
                    if inTransit[i] < k/2 {
                        right = append(right, inTransit[i])
                    } else {
                        left = append(left, inTransit[i])
                    }
                    inTransit = append(inTransit[:i], inTransit[i+1:]...)
                    i--
                } else {
                    time[inTransit[i]]--
                }
            }
        }

        if len(left) > 0 {
            for i := 0; i < len(left); i++ {
                if time[left[i]] == 0 {
                    waitLeft = append(waitLeft, left[i])
                    left = append(left[:i], left[i+1:]...)
                    i--
                }
            }
        }

        if len(right) > 0 {
            for i := 0; i < len(right); i++ {
                if time[right[i]] == 0 {
                    waitRight = append(waitRight, right[i])
                    right = append(right[:i], right[i+1:]...)
                    i--
                }
            }
        }

        if len(waitLeft) > 0 && len(waitRight) > 0 {
            for i := 0; i < len(waitLeft); i++ {
                if time[waitLeft[i]] == 0 {
                    inTransit = append(inTransit, waitLeft[i])
                    waitLeft = append(waitLeft[:i], waitLeft[i+1:]...)
                    i--
                }
            }
            for i := 0; i < len(waitRight); i++ {
                if time[waitRight[i]] == 0 {
                    inTransit = append(inTransit, waitRight[i])
                    waitRight = append(waitRight[:i], waitRight[i+1:]...)
                    i--
                }
            }
        } else if len(waitLeft) > 0 {
            for i := 0; i < len(waitLeft); i++ {
                if time[waitLeft[i]] == 0 {
                    inTransit = append(inTransit, waitLeft[i])
                    waitLeft = append(waitLeft[:i], waitLeft[i+1:]...)
                    i--
                }
            }
        } else if len(waitRight) > 0 {
            for i := 0; i < len(waitRight); i++ {
                if time[waitRight[i]] == 0 {
                    inTransit = append(inTransit, waitRight[i])
                    waitRight = append(waitRight[:i], waitRight[i+1:]...)
                    i--
                }
            }
        }

        if len(inTransit) == 0 {
            break
        }

        for i := 0; i < len(inTransit); i++ {
            time[inTransit[i]]--
        }
    }

    return n
}