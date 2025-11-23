function reversePairs(nums) {
    function mergeSort(arr, left, right) {
        if (left >= right) return 0;
        let mid = Math.floor((left + right) / 2);
        let count = mergeSort(arr, left, mid) + mergeSort(arr, mid + 1, right);
        let i = left, j = mid + 1;
        while (i <= mid && j <= right) {
            if (arr[i] > arr[j]) {
                count++;
                j++;
            } else {
                i++;
            }
        }
        let temp = [];
        i = left;
        j = mid + 1;
        while (i <= mid && j <= right) {
            if (arr[i] <= arr[j]) {
                temp.push(arr[i++]);
            } else {
                temp.push(arr[j++]);
            }
        }
        while (i <= mid) temp.push(arr[i++]);
        while (j <= right) temp.push(arr[j++]);
        for (let k = 0; k < temp.length; k++) {
            arr[left + k] = temp[k];
        }
        return count;
    }
    return mergeSort(nums, 0, nums.length - 1);
}