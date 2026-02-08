package main

import (
	"fmt"
	"sort"
	"strconv"
	"strings"
)

func invalidTransactions(transactions []string) []string {
	type Transaction struct {
		name   string
		time   int
		amount int
		city   string
	}

	var transList []Transaction
	invalid := make(map[string]bool)

	for _, transaction := range transactions {
		parts := strings.Split(transaction, ",")
		amount, _ := strconv.Atoi(parts[2])
		time, _ := strconv.Atoi(parts[1])
		transList = append(transList, Transaction{parts[0], time, amount, parts[3]})

		if amount > 1000 {
			invalid[transaction] = true
		}
	}

	for i := 0; i < len(transList); i++ {
		for j := 0; j < len(transList); j++ {
			if i != j && transList[i].name == transList[j].name && abs(transList[i].time-transList[j].time) <= 60 && transList[i].city != transList[j].city {
				invalid[transactions[i]] = true
				invalid[transactions[j]] = true
			}
		}
	}

	var result []string
	for transaction := range invalid {
		result = append(result, transaction)
	}

	sort.Strings(result)
	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func main() {
	transactions := []string{"alice,20,800,mtv","alice,50,100,beijing"}
	fmt.Println(invalidTransactions(transactions))
}