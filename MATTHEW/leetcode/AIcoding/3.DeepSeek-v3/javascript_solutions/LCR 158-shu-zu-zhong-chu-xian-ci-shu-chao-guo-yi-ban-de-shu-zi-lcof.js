var inventoryManagement = function(stock) {
    let candidate = null;
    let count = 0;

    for (const num of stock) {
        if (count === 0) {
            candidate = num;
            count = 1;
        } else if (candidate === num) {
            count++;
        } else {
            count--;
        }
    }

    return candidate;
};