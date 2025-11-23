function minimumAverage(nums) {
    let min = Math.min(...nums);
    let max = Math.max(...nums);
    return (min + max) / 2;
}