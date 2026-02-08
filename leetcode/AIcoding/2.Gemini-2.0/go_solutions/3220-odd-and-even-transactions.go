import "sort"

type Transaction struct {
	ID     int
	Amount int
	Type   string
}

func OddEvenTransactions(transactions []Transaction) []Transaction {
	odd := []Transaction{}
	even := []Transaction{}

	for _, t := range transactions {
		if t.Amount%2 == 0 {
			even = append(even, t)
		} else {
			odd = append(odd, t)
		}
	}

	sort.Slice(odd, func(i, j int) bool {
		return odd[i].ID < odd[j].ID
	})

	sort.Slice(even, func(i, j int) bool {
		return even[i].ID < even[j].ID
	})

	return append(odd, even...)
}