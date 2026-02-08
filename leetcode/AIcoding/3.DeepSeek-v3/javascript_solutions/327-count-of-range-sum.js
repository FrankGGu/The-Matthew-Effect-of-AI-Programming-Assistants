var countRangeSum = function(nums, lower, upper) {
    const prefixSum = [0];
    for (let num of nums) {
        prefixSum.push(prefixSum[prefixSum.length - 1] + num);
    }

    const temp = new Array(prefixSum.length).fill(0);

    const mergeSort = (left, right) => {
        if (left >= right) return 0;
        const mid = Math.floor((left + right) / 2);
        let count = mergeSort(left, mid) + mergeSort(mid + 1, right);

        let i = left, j = mid + 1, k = mid + 1;
        while (i <= mid) {
            while (j <= right && prefixSum[j] - prefixSum[i] < lower) j++;
            while (k <= right && prefixSum[k] - prefixSum[i] <= upper) k++;
            count += k - j;
            i++;
        }

        merge(left, mid, right);
        return count;
    };

    const merge = (left, mid, right) => {
        for (let i = left; i <= right; i++) {
            temp[i] = prefixSum[i];
        }
        let p = left, q = mid + 1, idx = left;
        while (p <= mid && q <= right) {
            if (temp[p] <= temp[q]) {
                prefixSum[idx++] = temp[p++];
            } else {
                prefixSum[idx++] = temp[q++];
            }
        }
        while (p <= mid) {
            prefixSum[idx++] = temp[p++];
        }
        while (q <= right) {
            prefixSum[idx++] = temp[q++];
        }
    };

    return mergeSort(0, prefixSum.length - 1);
};