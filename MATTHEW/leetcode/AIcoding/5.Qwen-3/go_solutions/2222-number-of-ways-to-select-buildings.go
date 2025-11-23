package main

func numberOfWays(s string) int {
    zeros := 0
    ones := 0
    zeroOne := 0
    oneZero := 0
    result := 0

    for _, c := range s {
        if c == '0' {
            zeros++
            result += oneZero
            zeroOne += ones
        } else {
            ones++
            result += zeroOne
            oneZero += zeros
        }
    }

    return result
}