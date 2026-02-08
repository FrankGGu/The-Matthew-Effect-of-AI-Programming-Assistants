var customSortString = function(order, s) {
    const orderMap = {};
    for (let i = 0; i < order.length; i++) {
        orderMap[order[i]] = i;
    }

    const sArray = s.split('');
    sArray.sort((a, b) => {
        const orderA = orderMap[a] === undefined ? Infinity : orderMap[a];
        const orderB = orderMap[b] === undefined ? Infinity : orderMap[b];
        return orderA - orderB;
    });

    return sArray.join('');
};