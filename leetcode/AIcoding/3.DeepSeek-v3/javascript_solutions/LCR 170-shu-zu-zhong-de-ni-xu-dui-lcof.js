var reversePairs = function(nums) {
    let count = 0;

    function mergeSort(nums, left, right) {
        if (left >= right) return;
        let mid = Math.floor((left + right) / 2);
        mergeSort(nums, left, mid);
        mergeSort(nums, mid + 1, right);
        merge(nums, left, mid, right);
    }

    function merge(nums, left, mid, right) {
        let temp = [];
        let i = left, j = mid + 1;
        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j]) {
                temp.push(nums[i++]);
            } else {
                temp.push(nums[j++]);
                count += mid - i + 1;
            }
        }
        while (i <= mid) {
            temp.push(nums[i++]);
        }
        while (j <= right) {
            temp.push(nums[j++]);
        }
        for (let k = 0; k < temp.length; k++) {
            nums[left + k] = temp[k];
        }
    }

    mergeSort(nums, 0, nums.length - 1);
    return count;
};