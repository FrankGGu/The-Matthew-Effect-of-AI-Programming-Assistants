var transform = function(nums, a, b, c) {
    let result = [];
    for (let num of nums) {
        result.push(a * num * num + b * num + c);
    }
    if (a >= 0) {
        result.sort((x, y) => x - y);
    } else {
        result.sort((x, y) => y - x);
    }
    return result;
};