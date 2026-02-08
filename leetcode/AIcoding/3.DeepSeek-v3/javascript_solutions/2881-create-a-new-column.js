var createNewColumn = function(items, operation, column1, column2, column3) {
    return items.map(item => {
        const val1 = item[column1];
        const val2 = item[column2];
        let newVal;

        switch (operation) {
            case '+':
                newVal = val1 + val2;
                break;
            case '-':
                newVal = val1 - val2;
                break;
            case '*':
                newVal = val1 * val2;
                break;
            case '/':
                newVal = val1 / val2;
                break;
            default:
                newVal = 0;
        }

        return {
            ...item,
            [column3]: newVal
        };
    });
};