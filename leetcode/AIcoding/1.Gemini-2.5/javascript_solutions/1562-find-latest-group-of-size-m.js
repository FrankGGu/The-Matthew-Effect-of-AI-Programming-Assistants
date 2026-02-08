var findLatestStep = function(n, arr, m) {
    const length_at_ends = new Array(n + 2).fill(0);
    const count_of_lengths = new Array(n + 1).fill(0);
    let ans = -1;

    for (let i = 0; i < n; i++) {
        const p = arr[i];

        const left_group_len = length_at_ends[p - 1];
        const right_group_len = length_at_ends[p + 1];

        const new_group_len = left_group_len + 1 + right_group_len;

        if (left_group_len > 0) {
            count_of_lengths[left_group_len]--;
        }
        if (right_group_len > 0) {
            count_of_lengths[right_group_len]--;
        }

        count_of_lengths[new_group_len]++;

        length_at_ends[p - left_group_len] = new_group_len;
        length_at_ends[p + right_group_len] = new_group_len;

        if (count_of_lengths[m] > 0) {
            ans = i + 1;
        }
    }

    return ans;
};