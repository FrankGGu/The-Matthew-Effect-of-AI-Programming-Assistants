var renameColumns = function(columns) {
    let result = [];
    for (let i = 0; i < columns.length; i++) {
        result.push(columns[i].replace(/_/g, ' ').replace(/\b\w/g, c => c.toUpperCase()));
    }
    return result;
};