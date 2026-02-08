var pivot = function(data, index, column, value) {
    const indexSet = new Set();
    const columnSet = new Set();

    for (const row of data) {
        indexSet.add(row[index]);
        columnSet.add(row[column]);
    }

    const indexArr = Array.from(indexSet).sort();
    const columnArr = Array.from(columnSet).sort();

    const result = [["" + index, ...columnArr]];

    const dataMap = new Map();
    for (const row of data) {
        const key = row[index];
        if (!dataMap.has(key)) {
            dataMap.set(key, new Map());
        }
        dataMap.get(key).set(row[column], row[value]);
    }

    for (const i of indexArr) {
        const row = [i];
        for (const c of columnArr) {
            if (dataMap.has(i) && dataMap.get(i).has(c)) {
                row.push(dataMap.get(i).get(c));
            } else {
                row.push(null);
            }
        }
        result.push(row);
    }

    return result;
};