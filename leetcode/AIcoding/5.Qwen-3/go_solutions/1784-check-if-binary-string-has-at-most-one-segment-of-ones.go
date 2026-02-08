package main

func checkIfAllOneSegmentsAreSingle(s string) bool {
    foundOne := false
    for i := 0; i < len(s); i++ {
        if s[i] == '1' {
            if foundOne {
                return false
            }
            foundOne = true
        } else {
            foundOne = false
        }
    }
    return true
}