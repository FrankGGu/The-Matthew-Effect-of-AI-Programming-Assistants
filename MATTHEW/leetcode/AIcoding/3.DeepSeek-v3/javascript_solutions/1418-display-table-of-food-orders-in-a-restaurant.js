var displayTable = function(orders) {
    const foodItems = new Set();
    const tableNumbers = new Set();
    const orderCounts = {};

    for (const order of orders) {
        const [_, table, food] = order;
        foodItems.add(food);
        tableNumbers.add(parseInt(table));

        const key = `${table}-${food}`;
        orderCounts[key] = (orderCounts[key] || 0) + 1;
    }

    const sortedFoods = Array.from(foodItems).sort();
    const sortedTables = Array.from(tableNumbers).sort((a, b) => a - b);

    const result = [['Table', ...sortedFoods]];

    for (const table of sortedTables) {
        const row = [table.toString()];
        for (const food of sortedFoods) {
            const key = `${table}-${food}`;
            row.push((orderCounts[key] || 0).toString());
        }
        result.push(row);
    }

    return result;
};