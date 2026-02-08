var displayTable = function(orders) {
    const foodItemsSet = new Set();
    const tableNumbersSet = new Set();
    const counts = new Map(); // Map<tableNumber, Map<foodItem, count>>

    for (const order of orders) {
        const tableNumber = order[1];
        const foodItem = order[2];

        foodItemsSet.add(foodItem);
        tableNumbersSet.add(tableNumber);

        if (!counts.has(tableNumber)) {
            counts.set(tableNumber, new Map());
        }
        const tableCounts = counts.get(tableNumber);
        tableCounts.set(foodItem, (tableCounts.get(foodItem) || 0) + 1);
    }

    const sortedFoodItems = Array.from(foodItemsSet).sort();
    const sortedTableNumbers = Array.from(tableNumbersSet)
                                .map(Number)
                                .sort((a, b) => a - b)
                                .map(String);

    const result = [];

    // Create header row
    const header = ["Table", ...sortedFoodItems];
    result.push(header);

    // Create data rows
    for (const tableNumStr of sortedTableNumbers) {
        const row = [tableNumStr];
        const tableCounts = counts.get(tableNumStr);

        for (const foodItem of sortedFoodItems) {
            const count = (tableCounts.get(foodItem) || 0);
            row.push(count.toString());
        }
        result.push(row);
    }

    return result;
};