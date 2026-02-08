type Cashier struct {
	n             int
	discount      int
	products      map[int]int
	customerCount int
}

func Constructor(n int, discount int, products []int, prices []int) Cashier {
	productMap := make(map[int]int)
	for i := 0; i < len(products); i++ {
		productMap[products[i]] = prices[i]
	}
	return Cashier{
		n:             n,
		discount:      discount,
		products:      productMap,
		customerCount: 0,
	}
}

func (this *Cashier) GetBill(product []int, amount []int) float64 {
	this.customerCount++

	var totalBill float64 = 0.0
	for i := 0; i < len(product); i++ {
		prodID := product[i]
		prodAmount := amount[i]

		price := this.products[prodID]
		totalBill += float64(price * prodAmount)
	}

	if this.customerCount%this.n == 0 {
		totalBill = totalBill * float64(100-this.discount) / 100.0
	}

	return totalBill
}