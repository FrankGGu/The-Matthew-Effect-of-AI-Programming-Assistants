var maximumNumberThatSumOfPricesIsLessThanOrEqualToK = function(n, k) {
    let low = 0;
    let high = n;
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let priceSum = 0;
        for (let i = 1; i <= mid; i++) {
            if ((i & (i - 1)) === 0) {
                priceSum++;
            }
        }

        if (priceSum <= k) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};