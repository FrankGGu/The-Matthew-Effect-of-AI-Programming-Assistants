func displayTable(orders [][]string) [][]string {
    foodItems := make(map[string]bool)
    tableOrders := make(map[int]map[string]int)

    for _, order := range orders {
        tableNum, _ := strconv.Atoi(order[1])
        food := order[2]
        foodItems[food] = true
        if _, ok := tableOrders[tableNum]; !ok {
            tableOrders[tableNum] = make(map[string]int)
        }
        tableOrders[tableNum][food]++
    }

    sortedFoods := make([]string, 0, len(foodItems))
    for food := range foodItems {
        sortedFoods = append(sortedFoods, food)
    }
    sort.Strings(sortedFoods)

    sortedTables := make([]int, 0, len(tableOrders))
    for table := range tableOrders {
        sortedTables = append(sortedTables, table)
    }
    sort.Ints(sortedTables)

    result := make([][]string, len(sortedTables)+1)
    result[0] = make([]string, len(sortedFoods)+1)
    result[0][0] = "Table"
    for i, food := range sortedFoods {
        result[0][i+1] = food
    }

    for i, table := range sortedTables {
        result[i+1] = make([]string, len(sortedFoods)+1)
        result[i+1][0] = strconv.Itoa(table)
        for j, food := range sortedFoods {
            count := tableOrders[table][food]
            result[i+1][j+1] = strconv.Itoa(count)
        }
    }

    return result
}