var numberOfPairs = function(nums1, nums2, diff) {
    const n = nums1.length;
    const nums = new Array(n);
    for (let i = 0; i < n; i++) {
        nums[i] = nums1[i] - nums2[i];
    }
    let count = 0;
    const temp = new Array(n);

    const mergeSort = (left, right) => {
        if (left >= right) return;
        const mid = Math.floor((left + right) / 2);
        mergeSort(left, mid);
        mergeSort(mid + 1, right);

        let i = left;
        let j = mid + 1;
        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j] + diff) {
                count += right - j + 1;
                i++;
            } else {
                j++;
            }
        }

        i = left;
        j = mid + 1;
        let k = left;
        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j]) {
                temp[k++] = nums[i++];
            } else {
                temp[k++] = nums[j++];
            }
        }
        while (i <= mid) {
            temp[k++] = nums[i++];
        }
        while (j <= right) {
            temp[k++] = nums[j++];
        }
        for (let p = left; p <= right; p++) {
            nums[p] = temp[p];
        }
    };

    mergeSort(0, n - 1);
    return count;
};