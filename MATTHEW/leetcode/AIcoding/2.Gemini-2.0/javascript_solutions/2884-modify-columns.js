var modifyColumns = function(array, columns) {
    return array.map(obj => {
        let newObj = {};
        for (let key in columns) {
            if (columns.hasOwnProperty(key)) {
                let value = columns[key];
                if (typeof value === 'string') {
                    newObj[key] = obj[value];
                } else if (typeof value === 'function') {
                    newObj[key] = value(obj);
                }
            }
        }
        return newObj;
    });
};