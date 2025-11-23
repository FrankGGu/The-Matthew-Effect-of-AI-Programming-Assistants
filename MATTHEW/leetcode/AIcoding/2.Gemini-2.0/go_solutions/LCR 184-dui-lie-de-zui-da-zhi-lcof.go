type Discount struct {
    product int
    percent int
}

type CheckoutSystem struct {
    prices    []int
    discounts map[int][]Discount
}

func Constructor(prices []int, discounts [][]int) CheckoutSystem {
    discountMap := make(map[int][]Discount)
    for _, discount := range discounts {
        product := discount[0]
        discountProduct := discount[1]
        discountPercent := discount[2]
        discountMap[product] = append(discountMap[product], Discount{product: discountProduct, percent: discountPercent})
    }
    return CheckoutSystem{prices: prices, discounts: discountMap}
}

func (this *CheckoutSystem) Price(product []int, amount []int) float64 {
    total := 0.0
    for i := 0; i < len(product); i++ {
        price := float64(this.prices[product[i]-1])
        quantity := float64(amount[i])
        total += price * quantity
    }

    for i := 0; i < len(product); i++ {
        discounts, ok := this.discounts[product[i]]
        if ok {
            for _, discount := range discounts {
                for j := 0; j < len(product); j++ {
                    if product[j] == discount.product {
                        price := float64(this.prices[product[j]-1])
                        quantity := float64(amount[j])
                        discountAmount := price * quantity * float64(discount.percent) / 100.0
                        total -= discountAmount
                    }
                }
            }
        }
    }
    return total
}