var relativeSortArray = function(arr1, arr2) {
    const order = {};
    for (let i = 0; i < arr2.length; i++) {
        order[arr2[i]] = i;
    }
    arr1.sort((a, b) => {
        const aInOrder = order.hasOwnProperty(a);
        const bInOrder = order.hasOwnProperty(b);
        if (aInOrder && bInOrder) {
            return order[a] - order[b];
        } else if (aInOrder) {
            return -1;
        } else if (bInOrder) {
            return 1;
        } else {
            return a - b;
        }
    });
    return arr1;
};