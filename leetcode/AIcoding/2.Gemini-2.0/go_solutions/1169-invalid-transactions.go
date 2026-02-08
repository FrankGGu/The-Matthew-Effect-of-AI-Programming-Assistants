import (
	"strconv"
	"strings"
)

type Transaction struct {
	Name   string
	Time   int
	Amount int
	City   string
	Index  int
}

func invalidTransactions(transactions []string) []string {
	transactionsParsed := make([]Transaction, len(transactions))
	for i, transaction := range transactions {
		parts := strings.Split(transaction, ",")
		time, _ := strconv.Atoi(parts[1])
		amount, _ := strconv.Atoi(parts[2])
		transactionsParsed[i] = Transaction{
			Name:   parts[0],
			Time:   time,
			Amount: amount,
			City:   parts[3],
			Index:  i,
		}
	}

	invalid := make(map[int]bool)
	for i := 0; i < len(transactionsParsed); i++ {
		if transactionsParsed[i].Amount > 1000 {
			invalid[transactionsParsed[i].Index] = true
		}
		for j := i + 1; j < len(transactionsParsed); j++ {
			if transactionsParsed[i].Name == transactionsParsed[j].Name &&
				transactionsParsed[i].City != transactionsParsed[j].City &&
				abs(transactionsParsed[i].Time-transactionsParsed[j].Time) <= 60 {
				invalid[transactionsParsed[i].Index] = true
				invalid[transactionsParsed[j].Index] = true
			}
		}
	}

	result := make([]string, 0)
	for i := 0; i < len(transactions); i++ {
		if _, ok := invalid[i]; ok {
			result = append(result, transactions[i])
		}
	}

	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}