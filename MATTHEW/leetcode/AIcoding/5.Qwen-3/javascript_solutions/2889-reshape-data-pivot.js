function pivotTable(df) {
    const result = {};
    for (const row of df) {
        const [name, country, score] = row;
        if (!result[name]) {
            result[name] = {};
        }
        result[name][country] = score;
    }

    const output = [];
    for (const name in result) {
        const obj = { name };
        for (const country in result[name]) {
            obj[country] = result[name][country];
        }
        output.push(obj);
    }

    return output;
}