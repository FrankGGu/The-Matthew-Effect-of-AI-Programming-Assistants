var countRangeSum = function(nums, lower, upper) {
    let n = nums.length;
    let sums = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        sums[i + 1] = sums[i] + nums[i];
    }

    let count = 0;

    function mergeSort(left, right) {
        if (left >= right) return;

        let mid = Math.floor((left + right) / 2);
        mergeSort(left, mid);
        mergeSort(mid + 1, right);

        let i = left;
        let j = mid + 1;
        let l = mid + 1;
        let r = mid + 1;

        while (i <= mid) {
            while (l <= right && sums[l] - sums[i] < lower) l++;
            while (r <= right && sums[r] - sums[i] <= upper) r++;
            count += r - l;
            i++;
        }

        let temp = [];
        i = left;
        j = mid + 1;
        let k = 0;

        while (i <= mid && j <= right) {
            if (sums[i] <= sums[j]) {
                temp[k++] = sums[i++];
            } else {
                temp[k++] = sums[j++];
            }
        }

        while (i <= mid) {
            temp[k++] = sums[i++];
        }

        while (j <= right) {
            temp[k++] = sums[j++];
        }

        for (i = left; i <= right; i++) {
            sums[i] = temp[i - left];
        }
    }

    mergeSort(0, n);
    return count;
};