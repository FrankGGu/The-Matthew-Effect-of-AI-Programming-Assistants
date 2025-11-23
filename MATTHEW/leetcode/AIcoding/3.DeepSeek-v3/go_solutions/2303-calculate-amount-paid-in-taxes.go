func calculateTax(brackets [][]int, income int) float64 {
    tax := 0.0
    prev := 0
    for _, bracket := range brackets {
        upper, percent := bracket[0], bracket[1]
        if income <= 0 {
            break
        }
        taxable := min(upper - prev, income)
        tax += float64(taxable * percent) / 100.0
        income -= taxable
        prev = upper
    }
    return tax
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}