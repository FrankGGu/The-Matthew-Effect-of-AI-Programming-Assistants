function maxElements(nums, limit) {
    nums.sort((a, b) => a - b);
    let count = 0;
    let sum = 0;

    for (let num of nums) {
        if (sum + num <= limit) {
            sum += num;
            count++;
        } else {
            break;
        }
    }

    return count;
}