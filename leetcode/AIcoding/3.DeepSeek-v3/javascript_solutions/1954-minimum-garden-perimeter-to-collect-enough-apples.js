var minimumPerimeter = function(neededApples) {
    let left = 1;
    let right = 100000;
    let answer = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const totalApples = 2 * mid * (mid + 1) * (2 * mid + 1);

        if (totalApples >= neededApples) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return 8 * answer;
};