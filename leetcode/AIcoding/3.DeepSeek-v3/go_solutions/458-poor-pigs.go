func poorPigs(buckets int, minutesToDie int, minutesToTest int) int {
    tests := minutesToTest / minutesToDie
    pigs := 0
    for pow(tests+1, pigs) < buckets {
        pigs++
    }
    return pigs
}

func pow(base, exponent int) int {
    result := 1
    for i := 0; i < exponent; i++ {
        result *= base
    }
    return result
}