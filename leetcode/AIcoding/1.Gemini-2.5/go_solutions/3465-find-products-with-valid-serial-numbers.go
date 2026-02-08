package main

import (
	"regexp"
)

type Product struct {
	ID           int
	SerialNumber string
}

func findProductsWithValidSerialNumbers(products []Product) []Product {
	validSerialPattern := regexp.MustCompile(`^SN-[A-Z]{4}\d{3}$`)

	var validProducts []Product
	for _, product := range products {
		if validSerialPattern.MatchString(product.SerialNumber) {
			validProducts = append(validProducts, product)
		}
	}
	return validProducts
}