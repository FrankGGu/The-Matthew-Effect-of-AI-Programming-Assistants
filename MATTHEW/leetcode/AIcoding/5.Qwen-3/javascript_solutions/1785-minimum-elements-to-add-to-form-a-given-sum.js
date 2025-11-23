function minElements(nums, minSum) {
    let count = 0;
    let sum = 0;
    for (let num of nums) {
        sum += num;
        if (sum >= minSum) {
            return count + 1;
        }
        count++;
    }
    return count + 1;
}