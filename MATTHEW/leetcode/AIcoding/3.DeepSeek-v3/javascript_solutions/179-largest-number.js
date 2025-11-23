var largestNumber = function(nums) {
    const compare = (a, b) => {
        const str1 = a.toString() + b.toString();
        const str2 = b.toString() + a.toString();
        return str2.localeCompare(str1);
    };

    nums.sort(compare);
    if (nums[0] === 0) return '0';
    return nums.join('');
};