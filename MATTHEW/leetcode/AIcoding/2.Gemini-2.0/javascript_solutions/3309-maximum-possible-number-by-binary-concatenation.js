var largestNumber = function(nums) {
    nums.sort((a, b) => {
        const ab = String(a) + String(b);
        const ba = String(b) + String(a);
        return ba.localeCompare(ab);
    });

    if (nums[0] === 0) {
        return "0";
    }

    return nums.join("");
};