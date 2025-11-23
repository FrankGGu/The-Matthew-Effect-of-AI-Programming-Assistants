var maximumTastiness = function(price, k) {
    price.sort((a, b) => a - b);
    let left = 0;
    let right = price[price.length - 1] - price[0];
    let answer = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (canFormBasket(price, k, mid)) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return answer;
};

function canFormBasket(price, k, minDiff) {
    let count = 1;
    let last = price[0];

    for (let i = 1; i < price.length; i++) {
        if (price[i] - last >= minDiff) {
            count++;
            last = price[i];
            if (count >= k) {
                return true;
            }
        }
    }

    return false;
}