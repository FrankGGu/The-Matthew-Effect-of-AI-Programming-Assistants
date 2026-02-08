func getSumGameResult(A string, B string) int {
    aSum, bSum := 0, 0
    aUnknown, bUnknown := 0, 0

    for i := 0; i < len(A); i++ {
        if A[i] == '?' {
            aUnknown++
        } else {
            aSum += int(A[i] - '0')
        }
    }

    for i := 0; i < len(B); i++ {
        if B[i] == '?' {
            bUnknown++
        } else {
            bSum += int(B[i] - '0')
        }
    }

    diff := (aSum + aUnknown * 9) - (bSum + bUnknown * 9)
    if diff > 0 {
        return 1
    } else if diff < 0 {
        return -1
    }
    return 0
}