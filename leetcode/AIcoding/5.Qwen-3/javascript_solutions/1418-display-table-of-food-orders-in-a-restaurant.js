function displayTable(strs) {
    const foods = new Set();
    const tables = new Set();
    const tableFoodMap = new Map();

    for (let i = 1; i < strs.length; i++) {
        const parts = strs[i].split(',');
        const table = parts[0];
        const food = parts[1];
        foods.add(food);
        tables.add(table);
        if (!tableFoodMap.has(table)) {
            tableFoodMap.set(table, new Map());
        }
        const foodCount = tableFoodMap.get(table).get(food) || 0;
        tableFoodMap.get(table).set(food, foodCount + 1);
    }

    const sortedFoods = Array.from(foods).sort();
    const sortedTables = Array.from(tables).sort((a, b) => parseInt(a) - parseInt(b));

    const result = [];
    result.push(['Table', ...sortedFoods]);

    for (const table of sortedTables) {
        const row = [table];
        for (const food of sortedFoods) {
            const count = tableFoodMap.get(table).get(food) || 0;
            row.push(count.toString());
        }
        result.push(row);
    }

    return result;
}