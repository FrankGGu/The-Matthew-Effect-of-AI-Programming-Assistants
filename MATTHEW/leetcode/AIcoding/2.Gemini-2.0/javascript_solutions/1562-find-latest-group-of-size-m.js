var findLatestStep = function(arr, m) {
    const n = arr.length;
    const length = new Array(n + 2).fill(0);
    const count = new Array(n + 1).fill(0);
    let ans = -1;

    for (let i = 0; i < n; i++) {
        const a = arr[i];
        const left = length[a - 1];
        const right = length[a + 1];
        length[a - left] = left + right + 1;
        length[a + right] = left + right + 1;
        length[a] = left + right + 1;

        if (left > 0) {
            count[left]--;
        }
        if (right > 0) {
            count[right]--;
        }
        count[left + right + 1]++;

        if (count[m] > 0) {
            ans = i + 1;
        }
    }

    return ans;
};