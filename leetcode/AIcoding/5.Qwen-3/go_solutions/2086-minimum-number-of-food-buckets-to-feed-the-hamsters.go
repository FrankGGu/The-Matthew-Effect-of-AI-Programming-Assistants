package main

func minFoodBuckets(hamsters string) int {
    n := len(hamsters)
    res := 0
    i := 0
    for i < n {
        if hamsters[i] == 'H' {
            if i+1 < n && hamsters[i+1] == 'H' {
                res++
                i += 2
            } else {
                res++
                i += 1
            }
        } else {
            i++
        }
    }
    return res
}