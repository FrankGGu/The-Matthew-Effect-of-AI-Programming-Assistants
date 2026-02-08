var countMatchingSubarrays = function(nums, pattern) {
    const n = nums.length;
    const m = pattern.length;

    const text_arr = [];
    for (let i = 0; i < n - 1; i++) {
        if (nums[i + 1] > nums[i]) {
            text_arr.push(1);
        } else if (nums[i + 1] < nums[i]) {
            text_arr.push(-1);
        } else {
            text_arr.push(0);
        }
    }

    const lps = new Array(m).fill(0);
    let length = 0;
    let i = 1;
    while (i < m) {
        if (pattern[i] === pattern[length]) {
            length++;
            lps[i] = length;
            i++;
        } else {
            if (length !== 0) {
                length = lps[length - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    let count = 0;
    let text_idx = 0;
    let pattern_idx = 0;

    const text_len = text_arr.length;

    while (text_idx < text_len) {
        if (pattern[pattern_idx] === text_arr[text_idx]) {
            text_idx++;
            pattern_idx++;
        }

        if (pattern_idx === m) {
            count++;
            pattern_idx = lps[pattern_idx - 1];
        } else if (text_idx < text_len && pattern[pattern_idx] !== text_arr[text_idx]) {
            if (pattern_idx !== 0) {
                pattern_idx = lps[pattern_idx - 1];
            } else {
                text_idx++;
            }
        }
    }

    return count;
};