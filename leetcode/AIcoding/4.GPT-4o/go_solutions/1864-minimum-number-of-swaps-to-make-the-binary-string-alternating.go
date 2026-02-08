func minSwaps(s string) int {
    n := len(s)
    count0 := 0
    count1 := 0

    for _, ch := range s {
        if ch == '0' {
            count0++
        } else {
            count1++
        }
    }

    if abs(count0-count1) > 1 {
        return -1
    }

    swaps1, swaps2 := 0, 0
    for i := 0; i < n; i++ {
        expected1 := '0' + rune(i%2) // Pattern starting with '0'
        expected2 := '1' - rune(i%2) // Pattern starting with '1'

        if rune(s[i]) != expected1 {
            swaps1++
        }
        if rune(s[i]) != expected2 {
            swaps2++
        }
    }

    if count0 == count1 {
        return min(swaps1/2, swaps2/2)
    }

    if count0 > count1 {
        return swaps1 / 2
    }

    return swaps2 / 2
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}