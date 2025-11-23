function inventoryManagement(stock, cnt) {
    let map = new Map();
    for (let i = 0; i < stock.length; i++) {
        if (map.has(stock[i])) {
            map.set(stock[i], map.get(stock[i]) + 1);
        } else {
            map.set(stock[i], 1);
        }
    }
    let result = [];
    for (let [key, value] of map.entries()) {
        if (value <= cnt) {
            result.push(key);
        }
    }
    return result;
}