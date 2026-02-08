var largestNumber = function(nums) {
    nums.sort((a, b) => {
        const strA = String(a);
        const strB = String(b);
        return (strB + strA).localeCompare(strA + strB);
    });

    if (nums[0] === 0) {
        return "0";
    }

    return nums.join('');
};