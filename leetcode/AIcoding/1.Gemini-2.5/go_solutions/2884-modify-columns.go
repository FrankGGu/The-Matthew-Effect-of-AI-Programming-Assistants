type Product struct {
    ProductID int
    Price     float64
    Discount  float64
}

func modifyColumns(products []Product) []Product {
    for i := range products {
        products[i].Price = products[i].Price * (1 - products[i].Discount)
    }
    return products
}