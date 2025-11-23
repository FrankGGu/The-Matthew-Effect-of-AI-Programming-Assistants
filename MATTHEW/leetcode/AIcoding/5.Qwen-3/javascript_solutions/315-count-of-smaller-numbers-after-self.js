function countSmaller(nums) {
    const result = new Array(nums.length).fill(0);
    const indexes = Array.from({ length: nums.length }, (_, i) => i);

    function mergeSort(arr, start, end) {
        if (start >= end) return;
        const mid = Math.floor((start + end) / 2);
        mergeSort(arr, start, mid);
        mergeSort(arr, mid + 1, end);
        merge(arr, start, mid, end);
    }

    function merge(arr, start, mid, end) {
        const temp = [];
        let i = start;
        let j = mid + 1;
        let k = start;

        while (i <= mid && j <= end) {
            if (nums[arr[i]] <= nums[arr[j]]) {
                temp.push(arr[i]);
                i++;
            } else {
                temp.push(arr[j]);
                result[arr[j]] += mid - i + 1;
                j++;
            }
        }

        while (i <= mid) {
            temp.push(arr[i]);
            i++;
        }

        while (j <= end) {
            temp.push(arr[j]);
            j++;
        }

        for (let l = 0; l < temp.length; l++) {
            arr[start + l] = temp[l];
        }
    }

    mergeSort(indexes, 0, indexes.length - 1);
    return result;
}