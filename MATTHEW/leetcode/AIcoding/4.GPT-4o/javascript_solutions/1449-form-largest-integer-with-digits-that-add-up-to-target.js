var largestInteger = function(target, A) {
    let sum = 0;
    let result = '';

    for (let num of A) {
        sum += num;
    }

    if (sum < target) return '';

    A.sort((a, b) => b - a);

    while (target > 0 && A.length > 0) {
        let maxNum = A[0];
        if (maxNum <= target) {
            result += maxNum;
            target -= maxNum;
            A.shift();
        } else {
            A.shift();
        }
    }

    return result;
};