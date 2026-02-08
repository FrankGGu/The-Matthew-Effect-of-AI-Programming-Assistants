var largestNumber = function(nums) {
    if (nums.length === 0) {
        return "";
    }

    const strNums = nums.map(String);

    strNums.sort((a, b) => {
        const order1 = a + b;
        const order2 = b + a;
        return order2.localeCompare(order1);
    });

    if (strNums[0] === '0') {
        return '0';
    }

    return strNums.join('');
};