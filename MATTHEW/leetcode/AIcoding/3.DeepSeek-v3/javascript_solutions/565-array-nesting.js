var arrayNesting = function(nums) {
    let maxSize = 0;
    const visited = new Array(nums.length).fill(false);

    for (let i = 0; i < nums.length; i++) {
        if (!visited[i]) {
            let start = nums[i], count = 0;
            do {
                start = nums[start];
                count++;
                visited[start] = true;
            } while (start !== nums[i]);
            maxSize = Math.max(maxSize, count);
        }
    }

    return maxSize;
};