function maximumTastiness(candies, numPeople) {
    candies.sort((a, b) => a - b);
    let left = 0, right = candies[candies.length - 1] - candies[0];
    let answer = 0;

    function canDistribute(tastiness) {
        let count = 0;
        let prev = -Infinity;
        for (let i = 0; i < candies.length; i++) {
            if (candies[i] - prev >= tastiness) {
                count++;
                prev = candies[i];
            }
        }
        return count >= numPeople;
    }

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (canDistribute(mid)) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return answer;
}