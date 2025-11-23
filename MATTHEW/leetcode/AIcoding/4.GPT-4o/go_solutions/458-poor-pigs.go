func poorPigs(buckets int, minutesToDie int, minutesToTest int) int {
    tests := minutesToTest / minutesToDie
    return int(math.Ceil(math.Log(float64(buckets)) / math.Log(float64(tests+1))))
}