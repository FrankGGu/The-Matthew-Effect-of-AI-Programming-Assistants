var canSortArray = function(nums) {
    let n = nums.length;
    let groups = [];
    let i = 0;
    while (i < n) {
        let j = i;
        let count = 0;
        while (j < n && (j === i || countBits(nums[j]) === countBits(nums[i]))) {
            count = countBits(nums[j]);
            j++;
        }
        groups.push(nums.slice(i, j));
        i = j;
    }

    for (let i = 0; i < groups.length - 1; i++) {
        if (groups[i][groups[i].length - 1] > groups[i + 1][0]) {
            return false;
        }
    }

    return true;

    function countBits(num) {
        let count = 0;
        while (num > 0) {
            count += (num & 1);
            num >>= 1;
        }
        return count;
    }
};