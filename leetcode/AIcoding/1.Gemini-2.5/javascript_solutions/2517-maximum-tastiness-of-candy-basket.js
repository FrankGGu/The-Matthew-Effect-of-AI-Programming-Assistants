var maximumTastiness = function(price, k) {
    price.sort((a, b) => a - b);
    const n = price.length;

    const check = (tastiness) => {
        let count = 1;
        let lastPickedPrice = price[0];
        for (let i = 1; i < n; i++) {
            if (price[i] - lastPickedPrice >= tastiness) {
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
    let high = price[n - 1] - price[0];
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};