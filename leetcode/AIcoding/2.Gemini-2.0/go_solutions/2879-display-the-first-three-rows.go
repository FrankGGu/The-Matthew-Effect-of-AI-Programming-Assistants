func displayTable(orders [][]string) [][]string {
    items := make(map[string]bool)
    tables := make(map[int]bool)
    tableOrders := make(map[int]map[string]int)

    for _, order := range orders {
        table, _ := strconv.Atoi(order[1])
        item := order[2]

        items[item] = true
        tables[table] = true

        if _, ok := tableOrders[table]; !ok {
            tableOrders[table] = make(map[string]int)
        }
        tableOrders[table][item]++
    }

    sortedItems := []string{}
    for item := range items {
        sortedItems = append(sortedItems, item)
    }
    sort.Strings(sortedItems)

    sortedTables := []int{}
    for table := range tables {
        sortedTables = append(sortedTables, table)
    }
    sort.Ints(sortedTables)

    result := [][]string{}
    header := []string{"Table"}
    header = append(header, sortedItems...)
    result = append(result, header)

    for _, table := range sortedTables {
        row := []string{strconv.Itoa(table)}
        for _, item := range sortedItems {
            count := 0
            if orders, ok := tableOrders[table]; ok {
                count = orders[item]
            }
            row = append(row, strconv.Itoa(count))
        }
        result = append(result, row)
    }

    return result
}