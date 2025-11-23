func calculateTax(brackets [][]int, income int) float64 {
    tax := 0.0
    previousLimit := 0

    for _, bracket := range brackets {
        limit := bracket[0]
        rate := bracket[1]

        if income > limit {
            tax += float64(limit-previousLimit) * float64(rate) / 100.0
            previousLimit = limit
        } else {
            tax += float64(income-previousLimit) * float64(rate) / 100.0
            break
        }
    }

    return tax
}