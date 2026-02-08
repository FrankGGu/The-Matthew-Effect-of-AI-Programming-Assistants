package main

import (
	"sort"
	"time"
)

type Sale struct {
	SaleID    int
	ProductID int
	SaleDate  string
	Amount    float64
}

type Product struct {
	ProductID   int
	ProductName string
}

type SeasonalSale struct {
	ProductName string
	Season      string
	TotalSales  float64
}

func analyzeSeasonalSales(sales []Sale, products []Product) []SeasonalSale {
	productNameMap := make(map[int]string)
	for _, p := range products {
		productNameMap[p.ProductID] = p.ProductName
	}

	seasonalSalesMap := make(map[string]map[string]float64)

	for _, s := range sales {
		productName, ok := productNameMap[s.ProductID]
		if !ok {
			continue
		}

		saleTime, err := time.Parse("2006-01-02", s.SaleDate)
		if err != nil {
			continue
		}

		month := saleTime.Month()
		var season string
		switch month {
		case time.December, time.January, time.February:
			season = "Winter"
		case time.March, time.April, time.May:
			season = "Spring"
		case time.June, time.July, time.August:
			season = "Summer"
		case time.September, time.October, time.November:
			season = "Autumn"
		default:
			season = "Unknown"
		}

		if _, ok := seasonalSalesMap[productName]; !ok {
			seasonalSalesMap[productName] = make(map[string]float64)
		}
		seasonalSalesMap[productName][season] += s.Amount
	}

	var result []SeasonalSale
	for productName, seasonsData := range seasonalSalesMap {
		for season, totalSales := range seasonsData {
			result = append(result, SeasonalSale{
				ProductName: productName,
				Season:      season,
				TotalSales:  totalSales,
			})
		}
	}

	sort.Slice(result, func(i, j int) bool {
		if result[i].ProductName != result[j].ProductName {
			return result[i].ProductName < result[j].ProductName
		}
		seasonOrder := map[string]int{
			"Winter": 1, "Spring": 2, "Summer": 3, "Autumn": 4,
		}
		return seasonOrder[result[i].Season] < seasonOrder[result[j].Season]
	})

	return result
}