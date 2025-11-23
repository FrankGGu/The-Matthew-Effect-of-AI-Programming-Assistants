var unmarkedSumArray = function(nums, queries) {
    let marked = new Array(nums.length).fill(false);
    let sum = nums.reduce((a, b) => a + b, 0);
    let markedSum = 0;
    let unmarkedIndices = nums.map((_, index) => index);
    unmarkedIndices.sort((a, b) => nums[a] - nums[b] || a - b);
    let pointer = 0;
    let result = [];

    for (let [index, k] of queries) {
        if (!marked[index]) {
            marked[index] = true;
            markedSum += nums[index];
        }

        let count = 0;
        while (count < k && pointer < unmarkedIndices.length) {
            let currentIndex = unmarkedIndices[pointer];
            if (!marked[currentIndex]) {
                marked[currentIndex] = true;
                markedSum += nums[currentIndex];
                count++;
            }
            pointer++;
        }

        result.push(sum - markedSum);
    }

    return result;
};