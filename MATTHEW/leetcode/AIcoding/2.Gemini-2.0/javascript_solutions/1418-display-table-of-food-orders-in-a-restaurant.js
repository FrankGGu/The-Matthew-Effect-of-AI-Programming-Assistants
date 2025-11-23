var displayTable = function(orders) {
    const foodItems = new Set();
    const tables = new Set();

    for (const order of orders) {
        tables.add(parseInt(order[1]));
        foodItems.add(order[2]);
    }

    const sortedTables = Array.from(tables).sort((a, b) => a - b);
    const sortedFoodItems = Array.from(foodItems).sort();

    const tableData = {};
    for (const table of sortedTables) {
        tableData[table] = {};
        for (const foodItem of sortedFoodItems) {
            tableData[table][foodItem] = 0;
        }
    }

    for (const order of orders) {
        const table = parseInt(order[1]);
        const foodItem = order[2];
        tableData[table][foodItem]++;
    }

    const result = [["Table", ...sortedFoodItems]];

    for (const table of sortedTables) {
        const row = [String(table)];
        for (const foodItem of sortedFoodItems) {
            row.push(String(tableData[table][foodItem]));
        }
        result.push(row);
    }

    return result;
};