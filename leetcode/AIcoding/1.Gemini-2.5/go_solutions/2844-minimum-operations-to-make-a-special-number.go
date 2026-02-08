import "math"

func minimumOperations(num string) int {
    n := len(num)
    minOps := math.MaxInt32

    targets := []string{"00", "25", "50", "75"}

    for _, target := range targets {
        yChar := target[1]