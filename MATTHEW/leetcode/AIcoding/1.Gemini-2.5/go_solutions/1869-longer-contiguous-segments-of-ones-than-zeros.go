func checkZeroOnes(s string) bool {
    maxOnes := 0
    maxZeros := 0
    currentOnes := 0
    currentZeros := 0

    for _, char := range s {
        if char == '1' {
            currentOnes++
            currentZeros = 0
            if currentOnes > maxOnes {
                maxOnes = currentOnes
            }
        } else { // char == '0'
            currentZeros++
            currentOnes = 0
            if currentZeros > maxZeros {
                maxZeros = currentZeros
            }
        }
    }

    return maxOnes > maxZeros
}