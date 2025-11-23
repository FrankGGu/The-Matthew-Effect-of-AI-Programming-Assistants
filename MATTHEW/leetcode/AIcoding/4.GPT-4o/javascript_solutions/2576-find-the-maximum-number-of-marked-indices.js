var maxNumOfMarkedIndices = function(nums) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let marked = new Array(n).fill(false);
    let count = 0;

    for (let i = 0; i < n / 2; i++) {
        if (marked[i]) continue;
        for (let j = n / 2; j < n; j++) {
            if (!marked[j] && nums[j] >= 2 * nums[i]) {
                marked[i] = true;
                marked[j] = true;
                count += 2;
                break;
            }
        }
    }
    return count + (n % 2 === 1 && !marked[n / 2] ? 1 : 0);
};