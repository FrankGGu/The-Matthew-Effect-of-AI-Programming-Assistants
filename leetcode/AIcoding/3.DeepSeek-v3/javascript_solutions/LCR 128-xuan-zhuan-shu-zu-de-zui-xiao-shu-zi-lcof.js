var stockManagement = function(stock) {
    let left = 0;
    let right = stock.length - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (stock[mid] < stock[right]) {
            right = mid;
        } else if (stock[mid] > stock[right]) {
            left = mid + 1;
        } else {
            right--;
        }
    }
    return stock[left];
};