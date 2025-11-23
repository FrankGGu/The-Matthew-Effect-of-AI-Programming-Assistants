function largestNumber(nums) {
    nums.sort((a, b) => {
        const ab = a.toString() + b.toString();
        const ba = b.toString() + a.toString();
        return ba.localeCompare(ab);
    });
    if (nums[0] === 0) return "0";
    return nums.join("");
}