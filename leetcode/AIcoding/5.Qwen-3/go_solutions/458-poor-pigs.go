package main

func poorPigs(buckets int, minutesToDie int, minutesToTest int) int {
    pigs := 0
    for {
        if buckets <= 1 {
            return pigs
        }
        buckets = (buckets + (minutesToTest / minutesToDie)) / (minutesToTest / minutesToDie)
        pigs++
    }
}