var arrayNesting = function(nums) {
    let maxLen = 0;
    let visited = new Array(nums.length).fill(false);

    for (let i = 0; i < nums.length; i++) {
        if (!visited[i]) {
            let count = 0;
            let curr = i;
            while (!visited[curr]) {
                visited[curr] = true;
                curr = nums[curr];
                count++;
            }
            maxLen = Math.max(maxLen, count);
        }
    }

    return maxLen;
};