var arrayNesting = function(nums) {
    let maxLength = 0;
    const visited = new Set();

    for (let i = 0; i < nums.length; i++) {
        if (!visited.has(i)) {
            let currentLength = 0;
            let j = i;

            while (!visited.has(j)) {
                visited.add(j);
                j = nums[j];
                currentLength++;
            }

            maxLength = Math.max(maxLength, currentLength);
        }
    }

    return maxLength;
};