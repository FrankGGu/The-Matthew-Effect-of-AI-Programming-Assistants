var minimumPerimeter = function(neededApples) {
    let low = 0;
    let high = 100000;
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let apples = 2 * mid * (mid + 1) * (2 * mid + 1);

        if (apples >= neededApples) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return 8 * ans;
};