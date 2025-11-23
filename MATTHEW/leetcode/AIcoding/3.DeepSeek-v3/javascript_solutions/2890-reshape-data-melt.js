var melt = function(data, columns) {
    const idVars = columns.id_vars;
    const valueVars = columns.value_vars;
    const varName = columns.var_name || 'variable';
    const valueName = columns.value_name || 'value';

    const result = [];

    for (const item of data) {
        const idPart = {};
        for (const idVar of idVars) {
            idPart[idVar] = item[idVar];
        }

        for (const valueVar of valueVars) {
            const newItem = {...idPart};
            newItem[varName] = valueVar;
            newItem[valueName] = item[valueVar];
            result.push(newItem);
        }
    }

    return result;
};