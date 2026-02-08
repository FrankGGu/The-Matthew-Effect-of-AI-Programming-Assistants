var largestNumber = function(nums) {
    nums.sort((a, b) => {
        const strA = a.toString();
        const strB = b.toString();
        return (strB + strA) - (strA + strB);
    });

    if (nums[0] === 0) {
        return '0';
    }

    return nums.join('');
};