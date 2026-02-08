var countSmaller = function(nums) {
    const n = nums.length;
    if (n === 0) {
        return [];
    }

    const ans = new Array(n).fill(0);
    const indexedNums = new Array(n);
    for (let i = 0; i < n; i++) {
        indexedNums[i] = [nums[i], i]; // [value, original_index]
    }

    function mergeSort(arr, low, high) {
        if (low >= high) {
            return;
        }

        const mid = Math.floor(low + (high - low) / 2);
        mergeSort(arr, low, mid);
        mergeSort(arr, mid + 1, high);
        merge(arr, low, mid, high);
    }

    function merge(arr, low, mid, high) {
        const temp = [];
        let i = low;
        let j = mid + 1;
        let rightCount = 0;

        while (i <= mid && j <= high) {
            if (arr[i][0] <= arr[j][0]) {
                ans[arr[i][1]] += rightCount;
                temp.push(arr[i]);
                i++;
            } else {
                temp.push(arr[j]);
                rightCount++;
                j++;
            }
        }

        while (i <= mid) {
            ans[arr[i][1]] += rightCount;
            temp.push(arr[i]);
            i++;
        }

        while (j <= high) {
            temp.push(arr[j]);
            j++;
        }

        for (let k = low; k <= high; k++) {
            arr[k] = temp[k - low];
        }
    }

    mergeSort(indexedNums, 0, n - 1);

    return ans;
};