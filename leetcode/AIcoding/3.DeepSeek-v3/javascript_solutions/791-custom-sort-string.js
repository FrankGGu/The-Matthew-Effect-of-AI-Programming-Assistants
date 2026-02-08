var customSortString = function(order, s) {
    const orderMap = {};
    for (let i = 0; i < order.length; i++) {
        orderMap[order[i]] = i;
    }

    return s.split('').sort((a, b) => {
        const aOrder = orderMap[a] !== undefined ? orderMap[a] : Infinity;
        const bOrder = orderMap[b] !== undefined ? orderMap[b] : Infinity;
        return aOrder - bOrder;
    }).join('');
};