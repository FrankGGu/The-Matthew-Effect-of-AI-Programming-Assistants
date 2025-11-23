package main

func largestTimeFromDigits(A []int) int {
    maxTime := -1
    for h1 := 0; h1 < 4; h1++ {
        for h2 := 0; h2 < 4; h2++ {
            if h1 == h2 {
                continue
            }
            hour := A[h1]*10 + A[h2]
            if hour >= 24 {
                continue
            }
            for m1 := 0; m1 < 4; m1++ {
                if m1 == h1 || m1 == h2 {
                    continue
                }
                for m2 := 0; m2 < 4; m2++ {
                    if m2 == h1 || m2 == h2 || m2 == m1 {
                        continue
                    }
                    minute := A[m1]*10 + A[m2]
                    if minute >= 60 {
                        continue
                    }
                    time := hour*60 + minute
                    if time > maxTime {
                        maxTime = time
                    }
                }
            }
        }
    }
    return maxTime
}