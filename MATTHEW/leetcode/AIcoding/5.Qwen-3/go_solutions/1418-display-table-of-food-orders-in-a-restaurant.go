package main

func displayTable(orders [][]string) [][]string {
    foodSet := make(map[string]bool)
    tableMap := make(map[string]map[string]int)

    for _, order := range orders {
        table := order[1]
        food := order[2]
        foodSet[food] = true

        if _, exists := tableMap[table]; !exists {
            tableMap[table] = make(map[string]int)
        }
        tableMap[table][food]++
    }

    foods := make([]string, 0, len(foodSet))
    for food := range foodSet {
        foods = append(foods, food)
    }
    sort.Strings(foods)

    tables := make([]string, 0, len(tableMap))
    for table := range tableMap {
        tables = append(tables, table)
    }
    sort.Strings(tables)

    result := make([][]string, len(tables)+1)
    result[0] = append([]string{"Table"}, foods...)

    for i, table := range tables {
        row := []string{table}
        for _, food := range foods {
            count := tableMap[table][food]
            row = append(row, strconv.Itoa(count))
        }
        result[i+1] = row
    }

    return result
}