var minimumSwaps = function(nums) {
    const n = nums.length;
    const digitSum = (num) => {
        let sum = 0;
        let str = num.toString();
        for (let i = 0; i < str.length; i++) {
            sum += parseInt(str[i]);
        }
        return sum;
    };

    const arr = nums.map(num => digitSum(num));
    const indices = Array.from({ length: n }, (_, i) => i);

    indices.sort((a, b) => {
        if (arr[a] !== arr[b]) {
            return arr[a] - arr[b];
        } else {
            return nums[a] - nums[b];
        }
    });

    let swaps = 0;
    const visited = new Array(n).fill(false);

    for (let i = 0; i < n; i++) {
        if (visited[i] || indices[i] === i) {
            continue;
        }

        let cycleSize = 0;
        let j = i;
        while (!visited[j]) {
            visited[j] = true;
            j = indices[j];
            cycleSize++;
        }

        swaps += cycleSize - 1;
    }

    return swaps;
};