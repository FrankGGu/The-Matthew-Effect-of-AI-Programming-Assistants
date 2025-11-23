function smallestEqual(nums) {
    let minIndex = Infinity;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === i) {
            minIndex = Math.min(minIndex, i);
        }
    }
    return minIndex === Infinity ? -1 : minIndex;
}