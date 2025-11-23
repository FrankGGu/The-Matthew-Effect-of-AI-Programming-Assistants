var numberOfPairs = function(nums1, nums2, diff) {
    let n = nums1.length;
    let arr = new Array(n);
    for (let i = 0; i < n; i++) {
        arr[i] = nums1[i] - nums2[i];
    }

    let count = 0;

    function mergeSort(low, high) {
        if (low >= high) {
            return;
        }

        let mid = Math.floor((low + high) / 2);
        mergeSort(low, mid);
        mergeSort(mid + 1, high);
        merge(low, mid, high);
    }

    function merge(low, mid, high) {
        // Counting step
        // For each element arr[i] in the left half (low to mid),
        // we need to find elements arr[j] in the right half (mid+1 to high)
        // such that arr[i] <= arr[j] + diff, which is arr[i] - diff <= arr[j].
        let k = mid + 1;
        for (let i = low; i <= mid; i++) {
            while (k <= high && arr[k] < arr[i] - diff) {
                k++;
            }
            // All elements from arr[k] to arr[high] satisfy the condition
            count += (high - k + 1);
        }

        // Standard merge step
        let temp = [];
        let i = low;
        let j = mid + 1;

        while (i <= mid && j <= high) {
            if (arr[i] <= arr[j]) {
                temp.push(arr[i++]);
            } else {
                temp.push(arr[j++]);
            }
        }

        while (i <= mid) {
            temp.push(arr[i++]);
        }

        while (j <= high) {
            temp.push(arr[j++]);
        }

        for (let x = 0; x < temp.length; x++) {
            arr[low + x] = temp[x];
        }
    }

    mergeSort(0, n - 1);
    return count;
};