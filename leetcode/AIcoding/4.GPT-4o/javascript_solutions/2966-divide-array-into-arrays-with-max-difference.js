function divideArray(nums) {
    const count = new Array(101).fill(0);
    for (const num of nums) {
        count[num]++;
    }
    let pairs = 0;
    for (const c of count) {
        pairs += Math.floor(c / 2);
    }
    return pairs >= nums.length / 2;
}