package main

func maxAmountAfterTwoDays(conversions map[string]map[string]float64) float64 {
    maxAmount := 0.0
    for fromCurrency, toMap := range conversions {
        for toCurrency, rate := range toMap {
            if _, ok := conversions[toCurrency]; ok {
                for nextTo, nextRate := range conversions[toCurrency] {
                    total := rate * nextRate
                    if total > maxAmount {
                        maxAmount = total
                    }
                }
            }
        }
    }
    return maxAmount
}