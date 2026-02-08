func partitionLabels(s string) []int {
    lastPos := make([]int, 26)
    for i, char := range s {
        lastPos[char-'a'] = i
    }

    var result []int
    start := 0
    end := 0

    for i := 0; i < len