var displayTable = function(orders) {
    const foodSet = new Set();
    const tableMap = new Map();

    for (const [name, table, food] of orders) {
        foodSet.add(food);
        if (!tableMap.has(table)) {
            tableMap.set(table, new Map());
        }
        if (!tableMap.get(table).has(food)) {
            tableMap.get(table).set(food, 0);
        }
        tableMap.get(table).set(food, tableMap.get(table).get(food) + 1);
    }

    const foodList = Array.from(foodSet).sort();
    const tables = Array.from(tableMap.keys()).sort((a, b) => a - b);
    const result = [["Table"].concat(foodList)];

    for (const table of tables) {
        const row = [table];
        for (const food of foodList) {
            row.push(tableMap.get(table).get(food) || 0);
        }
        result.push(row);
    }

    return result;
};