function countInversions(nums) {
    let temp = new Array(nums.length);
    let mergeSortAndCount = (arr, temp, left, right) => {
        let mid, invCount = 0;
        if (left < right) {
            mid = Math.floor((left + right) / 2);
            invCount += mergeSortAndCount(arr, temp, left, mid);
            invCount += mergeSortAndCount(arr, temp, mid + 1, right);
            invCount += mergeAndCount(arr, temp, left, mid, right);
        }
        return invCount;
    };

    let mergeAndCount = (arr, temp, left, mid, right) => {
        let i = left; 
        let j = mid + 1; 
        let k = left; 
        let invCount = 0;

        while (i <= mid && j <= right) {
            if (arr[i] <= arr[j]) {
                temp[k++] = arr[i++];
            } else {
                temp[k++] = arr[j++];
                invCount += (mid - i + 1);
            }
        }

        while (i <= mid) {
            temp[k++] = arr[i++];
        }

        while (j <= right) {
            temp[k++] = arr[j++];
        }

        for (let m = left; m <= right; m++) {
            arr[m] = temp[m];
        }
        return invCount;
    };

    return mergeSortAndCount(nums, temp, 0, nums.length - 1);
}