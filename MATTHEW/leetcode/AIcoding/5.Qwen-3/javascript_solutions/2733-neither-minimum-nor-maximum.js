function findNonMinOrMax(nums) {
    if (nums.length <= 2) return -1;
    let min = Math.min(...nums);
    let max = Math.max(...nums);
    for (let num of nums) {
        if (num !== min && num !== max) {
            return num;
        }
    }
    return -1;
}