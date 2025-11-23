var minimumRightShifts = function(nums) {
    let n = nums.length;
    let sorted = [...nums].sort((a, b) => a - b);

    for (let k = 0; k < n; k++) {
        let isSorted = true;
        for (let i = 0; i < n; i++) {
            if (nums[(i + k) % n] !== sorted[i]) {
                isSorted = false;
                break;
            }
        }
        if (isSorted) return k;
    }
    return -1;
};