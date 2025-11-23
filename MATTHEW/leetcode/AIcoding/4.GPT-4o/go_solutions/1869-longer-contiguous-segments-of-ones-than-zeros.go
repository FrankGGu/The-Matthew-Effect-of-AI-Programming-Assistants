func checkZeroOnes(s string) bool {
    onesCount, zerosCount := 0, 0
    maxOnes, maxZeros := 0, 0

    for i := 0; i < len(s); i++ {
        if s[i] == '1' {
            onesCount++
            zerosCount = 0
        } else {
            zerosCount++
            onesCount = 0
        }
        if onesCount > maxOnes {
            maxOnes = onesCount
        }
        if zerosCount > maxZeros {
            maxZeros = zerosCount
        }
    }

    return maxOnes > maxZeros
}