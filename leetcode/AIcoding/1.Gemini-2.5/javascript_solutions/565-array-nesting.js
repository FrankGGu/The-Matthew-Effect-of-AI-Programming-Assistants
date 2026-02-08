var arrayNesting = function(nums) {
    let maxLength = 0;
    const n = nums.length;
    const visited = new Array(n).fill(false);

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            let currentLength = 0;
            let start = i;
            while (!visited[start]) {
                visited[start] = true;
                currentLength++;
                start = nums[start];
            }
            maxLength = Math.max(maxLength, currentLength);
        }
    }

    return maxLength;
};