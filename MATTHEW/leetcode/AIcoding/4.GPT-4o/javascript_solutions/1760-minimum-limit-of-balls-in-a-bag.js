var minimumSize = function(bags, maxOperations) {
    let left = 1, right = Math.max(...bags);
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let ops = 0;
        for (let bag of bags) {
            ops += Math.ceil(bag / mid) - 1;
        }
        if (ops > maxOperations) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
};