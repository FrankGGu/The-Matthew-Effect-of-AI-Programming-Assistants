var smallestRange = function(nums) {
    let k = nums.length;
    let pq = [];
    let max = -Infinity;

    for (let i = 0; i < k; i++) {
        pq.push({ val: nums[i][0], row: i, col: 0 });
        max = Math.max(max, nums[i][0]);
    }

    pq.sort((a, b) => a.val - b.val);

    let range = [pq[0].val, max];
    let minRange = max - pq[0].val;

    while (true) {
        let min = pq.shift();
        let row = min.row;
        let col = min.col;

        if (col + 1 >= nums[row].length) {
            break;
        }

        pq.push({ val: nums[row][col + 1], row: row, col: col + 1 });
        max = Math.max(max, nums[row][col + 1]);

        pq.sort((a, b) => a.val - b.val);

        if (max - pq[0].val < minRange) {
            minRange = max - pq[0].val;
            range = [pq[0].val, max];
        }
    }

    return range;
};