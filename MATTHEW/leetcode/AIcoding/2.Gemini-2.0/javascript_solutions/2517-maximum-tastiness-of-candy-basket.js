var maximumTastiness = function(price, k) {
    price.sort((a, b) => a - b);

    let left = 0;
    let right = price[price.length - 1] - price[0];
    let ans = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        let count = 1;
        let prev = price[0];

        for (let i = 1; i < price.length; i++) {
            if (price[i] - prev >= mid) {
                count++;
                prev = price[i];
            }
        }

        if (count >= k) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
};