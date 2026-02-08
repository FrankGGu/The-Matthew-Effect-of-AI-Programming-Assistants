type FrequencyTracker struct {
    // counts stores number -> frequency
    counts map[int]int
    // freqCounts stores frequency -> count of numbers having that frequency
    freqCounts map[int]int
}

func Constructor() FrequencyTracker {
    return FrequencyTracker{
        counts:     make(map[int]int),