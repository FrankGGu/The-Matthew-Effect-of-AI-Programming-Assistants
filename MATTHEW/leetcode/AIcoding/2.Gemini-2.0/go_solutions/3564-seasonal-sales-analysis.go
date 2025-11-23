import "fmt"

type Product struct {
	ProductID int
	PurchaseDate string
	Price int
}

func seasonalSales(products []Product) map[int][]int {
	seasonalSales := make(map[int][]int)
	for _, product := range products {
		month := getMonth(product.PurchaseDate)
		if month >= 3 && month <= 5 {
			seasonalSales[product.ProductID] = append(seasonalSales[product.ProductID], product.Price)
		} else if month >= 6 && month <= 8 {
			seasonalSales[product.ProductID] = append(seasonalSales[product.ProductID], product.Price)
		} else if month >= 9 && month <= 11 {
			seasonalSales[product.ProductID] = append(seasonalSales[product.ProductID], product.Price)
		} else {
			seasonalSales[product.ProductID] = append(seasonalSales[product.ProductID], product.Price)
		}
	}
	return seasonalSales
}

func getMonth(date string) int {
	month := 0
	fmt.Sscanf(date, "%d-%d-%d", new(int), &month, new(int))
	return month
}