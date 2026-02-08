func readBinaryWatch(turnedOn int) []string {
    result := []string{}
    for h := 0; h < 12; h++ {
        for m := 0; m < 60; m++ {
            if countBits(h)+countBits(m) == turnedOn {
                result = append(result, fmt.Sprintf("%d:%02d", h, m))
            }
        }
    }
    return result
}

func countBits(n int) int {
    count := 0
    for n > 0 {
        count += n & 1
        n >>= 1
    }
    return count
}