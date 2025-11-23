var solve = function(stock, operations) {
    for (let operation of operations) {
        const [type, item] = operation.split(' ');
        if (type === 'add') {
            stock.push(item);
        } else if (type === 'remove') {
            const index = stock.indexOf(item);
            if (index !== -1) {
                stock.splice(index, 1);
            }
        }
    }
    return stock.sort();
};