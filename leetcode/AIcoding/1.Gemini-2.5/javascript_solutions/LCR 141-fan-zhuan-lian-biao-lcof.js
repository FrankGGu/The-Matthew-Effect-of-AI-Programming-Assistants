var maximumTastiness = function(price, k) {
    price.sort((a, b) => a - b);

    const check = (x) => {
        let count = 1;
        let lastPickedPrice = price[0];
        for (let i = 1; i < price.length; i++) {
            if (price[i] - lastPickedPrice >= x) {
                count++;
                lastPickedPrice = price[i];
            }
            if (count === k) {
                return true;
            }
        }
        return false;
    };

    let low = 0;
    let high = price[price.length - 1] - price[0];
    let ans = 0;

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};