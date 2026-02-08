import (
    "sort"
)

func displayTable(orders [][]string) [][]string {
    foodItems := make(map[string]map[string]int)
    tables := make(map[string]bool)

    for _, order := range orders {
        table := order[1]
        food := order[2]
        if foodItems[food] == nil {
            foodItems[food] = make(map[string]int)
        }
        foodItems[food][table]++
        tables[table] = true
    }

    sortedFood := make([]string, 0, len(foodItems))
    for food := range foodItems {
        sortedFood = append(sortedFood, food)
    }
    sort.Strings(sortedFood)

    sortedTables := make([]string, 0, len(tables))
    for table := range tables {
        sortedTables = append(sortedTables, table)
    }
    sort.Strings(sortedTables)

    result := [][]string{{"Table"}}
    result[0] = append(result[0], sortedFood...)

    for _, table := range sortedTables {
        row := []string{table}
        for _, food := range sortedFood {
            row = append(row, strconv.Itoa(foodItems[food][table]))
        }
        result = append(result, row)
    }

    return result
}