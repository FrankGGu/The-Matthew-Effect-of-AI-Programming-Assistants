var findMinBrewTime = function(potions, target) {
    let left = 1;
    let right = Math.max(...potions) * target;
    let answer = right;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let total = 0;

        for (let potion of potions) {
            total += Math.floor(mid / potion);
            if (total >= target) {
                break;
            }
        }

        if (total >= target) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return answer;
};