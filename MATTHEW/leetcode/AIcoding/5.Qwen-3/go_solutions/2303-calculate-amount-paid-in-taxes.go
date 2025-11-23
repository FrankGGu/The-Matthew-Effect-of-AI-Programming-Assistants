package main

func CalculateTax(buckets []int, taxRates [][]int) float64 {
    var total float64
    for i := 0; i < len(buckets); i++ {
        for j := 0; j < len(taxRates); j++ {
            if buckets[i] >= taxRates[j][0] {
                continue
            }
            if j == 0 {
                total += float64(buckets[i]) * float64(taxRates[j][1]) / 100
            } else {
                total += float64(buckets[i]-taxRates[j-1][0]) * float64(taxRates[j][1]) / 100
            }
            break
        }
    }
    return total
}