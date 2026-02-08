var createDataFrame = function(data, columns) {
    return data.map(row => {
        let obj = {};
        for (let i = 0; i < columns.length; i++) {
            obj[columns[i]] = row[i];
        }
        return obj;
    });
};