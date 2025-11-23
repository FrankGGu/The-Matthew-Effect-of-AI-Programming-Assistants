var countRangeSum = function(nums, lower, upper) {
    const prefixSums = [0];
    for (let num of nums) {
        prefixSums.push(prefixSums[prefixSums.length - 1] + num);
    }

    const mergeSort = (start, end) => {
        if (start >= end) return 0;
        const mid = Math.floor((start + end) / 2);
        let count = mergeSort(start, mid) + mergeSort(mid + 1, end);

        let j = mid + 1, k = mid + 1;
        const temp = [];
        for (let i = start; i <= mid; i++) {
            while (j <= end && prefixSums[j] - prefixSums[i] < lower) j++;
            while (k <= end && prefixSums[k] - prefixSums[i] <= upper) k++;
            count += k - j;
        }

        for (let i = start; i <= end; i++) {
            temp[i - start] = prefixSums[i];
        }
        for (let i = start; i <= end; i++) {
            prefixSums[i] = temp[i - start];
        }

        return count;
    };

    return mergeSort(0, prefixSums.length - 1);
};