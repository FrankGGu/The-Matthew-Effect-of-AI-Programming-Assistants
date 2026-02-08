function minimumSwaps(nums) {
    const n = nums.length;
    const arr = nums.map((num, index) => [num, index]);
    arr.sort((a, b) => a[0] - b[0]);
    const visited = new Array(n).fill(false);
    let swaps = 0;

    for (let i = 0; i < n; i++) {
        if (visited[i] || arr[i][1] === i) {
            continue;
        }
        let cycleSize = 0;
        let j = i;

        while (!visited[j]) {
            visited[j] = true;
            j = arr[j][1];
            cycleSize++;
        }
        if (cycleSize > 0) {
            swaps += cycleSize - 1;
        }
    }
    return swaps;
}