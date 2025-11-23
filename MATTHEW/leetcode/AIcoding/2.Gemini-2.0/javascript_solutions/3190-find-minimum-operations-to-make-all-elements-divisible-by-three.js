var minOperations = function(nums) {
    let ones = 0;
    let twos = 0;
    let sum = 0;

    for (let num of nums) {
        sum += num;
        if (num % 3 === 1) {
            ones++;
        } else if (num % 3 === 2) {
            twos++;
        }
    }

    if (sum % 3 === 0) {
        return 0;
    } else if (sum % 3 === 1) {
        if (ones >= 1) {
            return 1;
        } else if (twos >= 2) {
            return 2;
        } else {
            return -1;
        }
    } else {
        if (twos >= 1) {
            return 1;
        } else if (ones >= 2) {
            return 2;
        } else {
            return -1;
        }
    }
};