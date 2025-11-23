function largestNumber(nums) {
    if (nums.length === 0) return "0";

    nums = nums.map(String);

    nums.sort((a, b) => {
        const ab = a + b;
        const ba = b + a;
        return ba.localeCompare(ab);
    });

    if (nums[0] === "0") return "0";

    return nums.join("");
}