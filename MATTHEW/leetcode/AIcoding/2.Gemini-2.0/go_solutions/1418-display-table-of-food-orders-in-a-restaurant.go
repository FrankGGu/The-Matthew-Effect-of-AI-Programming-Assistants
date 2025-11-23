import (
	"sort"
	"strconv"
)

func displayTable(orders [][]string) [][]string {
	foodItems := make(map[string]bool)
	tables := make(map[int]bool)
	orderMap := make(map[int]map[string]int)

	for _, order := range orders {
		tableNum, _ := strconv.Atoi(order[1])
		food := order[2]

		foodItems[food] = true
		tables[tableNum] = true

		if _, ok := orderMap[tableNum]; !ok {
			orderMap[tableNum] = make(map[string]int)
		}
		orderMap[tableNum][food]++
	}

	foodList := make([]string, 0, len(foodItems))
	for food := range foodItems {
		foodList = append(foodList, food)
	}
	sort.Strings(foodList)

	tableList := make([]int, 0, len(tables))
	for table := range tables {
		tableList = append(tableList, table)
	}
	sort.Ints(tableList)

	result := make([][]string, 0, len(tableList)+1)
	header := []string{"Table"}
	header = append(header, foodList...)
	result = append(result, header)

	for _, tableNum := range tableList {
		row := []string{strconv.Itoa(tableNum)}
		for _, food := range foodList {
			count := orderMap[tableNum][food]
			row = append(row, strconv.Itoa(count))
		}
		result = append(result, row)
	}

	return result
}