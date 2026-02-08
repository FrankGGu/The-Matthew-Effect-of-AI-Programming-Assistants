package main

func countSegments(s string) int {
    count := 0
    inSegment := false
    for _, c := range s {
        if c != ' ' {
            if !inSegment {
                inSegment = true
                count++
            }
        } else {
            inSegment = false
        }
    }
    return count
}