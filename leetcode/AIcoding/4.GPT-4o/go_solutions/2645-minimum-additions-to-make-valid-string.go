func addMinimum(s string) int {
    required := 0
    expected := 'a'

    for _, char := range s {
        for expected < char {
            required++
            expected++
        }
        if expected == char {
            expected++
        }
    }

    for expected <= 'c' {
        required++
        expected++
    }

    return required
}