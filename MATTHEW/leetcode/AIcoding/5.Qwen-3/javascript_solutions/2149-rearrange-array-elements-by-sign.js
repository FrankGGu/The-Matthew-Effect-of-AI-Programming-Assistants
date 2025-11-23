function rearrangeArray(nums) {
    const positive = [];
    const negative = [];
    for (const num of nums) {
        if (num > 0) {
            positive.push(num);
        } else {
            negative.push(num);
        }
    }
    const result = [];
    for (let i = 0; i < positive.length; i++) {
        result.push(positive[i]);
        result.push(negative[i]);
    }
    return result;
}