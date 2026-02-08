function findTheKey(nums) {
    let count = {};
    for (let num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    for (let num of nums) {
        if (count[num] === 1) {
            return num;
        }
    }
    return -1;
}