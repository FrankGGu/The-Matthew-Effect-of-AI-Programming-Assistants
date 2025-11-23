package main

func checkZeroOnes(s string) bool {
    maxOne := 0
    maxZero := 0
    currentOne := 0
    currentZero := 0

    for _, c := range s {
        if c == '1' {
            currentOne++
            currentZero = 0
            if currentOne > maxOne {
                maxOne = currentOne
            }
        } else {
            currentZero++
            currentOne = 0
            if currentZero > maxZero {
                maxZero = currentZero
            }
        }
    }

    return maxOne > maxZero
}