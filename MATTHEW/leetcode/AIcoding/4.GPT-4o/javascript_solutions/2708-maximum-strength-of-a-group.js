function maxStrength(nums) {
    let positive = [];
    let negative = [];
    let zeroCount = 0;

    for (let num of nums) {
        if (num > 0) {
            positive.push(num);
        } else if (num < 0) {
            negative.push(num);
        } else {
            zeroCount++;
        }
    }

    negative.sort((a, b) => a - b);
    let negativeProduct = 1;

    if (negative.length % 2 !== 0) {
        negative.pop();
    }

    for (let num of positive) {
        negativeProduct *= num;
    }

    for (let num of negative) {
        negativeProduct *= num;
    }

    if (negativeProduct === 1 && positive.length === 0 && zeroCount > 0) {
        return 0;
    }

    return negativeProduct;
}