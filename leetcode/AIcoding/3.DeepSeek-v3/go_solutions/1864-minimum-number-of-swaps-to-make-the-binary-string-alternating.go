func minSwaps(s string) int {
    count1 := 0
    count0 := 0
    for _, c := range s {
        if c == '1' {
            count1++
        } else {
            count0++
        }
    }
    if abs(count1 - count0) > 1 {
        return -1
    }

    var diff1, diff2 int
    for i := 0; i < len(s); i++ {
        expected := byte('0' + i % 2)
        if s[i] != expected {
            diff1++
        }
    }
    for i := 0; i < len(s); i++ {
        expected := byte('0' + (i + 1) % 2)
        if s[i] != expected {
            diff2++
        }
    }

    if diff1 % 2 != 0 {
        return diff2 / 2
    }
    if diff2 % 2 != 0 {
        return diff1 / 2
    }
    return min(diff1 / 2, diff2 / 2)
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