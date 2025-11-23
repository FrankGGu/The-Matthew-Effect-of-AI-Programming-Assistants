type Books struct {
	BookId int
	Name   string
}

type Orders struct {
	OrderNo  int
	BookId   int
	Quantity int
	DispatchDate string
}

func findBooks(books []Books, orders []Orders) []int {
	bookQuantity := make(map[int]int)
	for _, order := range orders {
		bookQuantity[order.BookId] += order.Quantity
	}

	result := []int{}
	for _, book := range books {
		if bookQuantity[book.BookId] > 0 {
			result = append(result, book.BookId)
		}
	}

	return result
}