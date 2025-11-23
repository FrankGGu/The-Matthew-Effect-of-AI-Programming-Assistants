var rearrangeArray = function(nums) {
    let positive = [];
    let negative = [];
    for (let num of nums) {
        if (num > 0) {
            positive.push(num);
        } else {
            negative.push(num);
        }
    }
    let result = [];
    for (let i = 0; i < positive.length; i++) {
        result.push(positive[i]);
        result.push(negative[i]);
    }
    return result;
};