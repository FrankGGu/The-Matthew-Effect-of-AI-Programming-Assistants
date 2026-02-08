package main

import "sort"

func inventoryManagement(stock []int, k int) []int {
	sort.Ints(stock)
	return stock[:k]
}