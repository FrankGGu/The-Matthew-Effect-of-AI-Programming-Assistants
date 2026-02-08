var sortEvenOdd = function(nums) {
    const even = [];
    const odd = [];
    for (let i = 0; i < nums.length; i++) {
        if (i % 2 === 0) {
            even.push(nums[i]);
        } else {
            odd.push(nums[i]);
        }
    }
    even.sort((a, b) => a - b);
    odd.sort((a, b) => b - a);
    const result = [];
    let evenIndex = 0;
    let oddIndex = 0;
    for (let i = 0; i < nums.length; i++) {
        if (i % 2 === 0) {
            result.push(even[evenIndex]);
            evenIndex++;
        } else {
            result.push(odd[oddIndex]);
            oddIndex++;
        }
    }
    return result;
};