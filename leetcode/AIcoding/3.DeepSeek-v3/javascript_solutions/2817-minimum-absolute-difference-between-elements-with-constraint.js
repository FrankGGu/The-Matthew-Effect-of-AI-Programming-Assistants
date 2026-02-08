var minAbsoluteDifference = function(nums, x) {
    const sorted = [];
    let minDiff = Infinity;

    for (let i = 0; i < nums.length; i++) {
        if (i >= x) {
            const num = nums[i];
            let left = 0, right = sorted.length - 1;
            let closest = Infinity;

            while (left <= right) {
                const mid = Math.floor((left + right) / 2);
                if (sorted[mid] === num) {
                    closest = 0;
                    break;
                } else if (sorted[mid] < num) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if (closest !== 0) {
                if (left < sorted.length) {
                    closest = Math.min(closest, Math.abs(num - sorted[left]));
                }
                if (right >= 0) {
                    closest = Math.min(closest, Math.abs(num - sorted[right]));
                }
            }

            minDiff = Math.min(minDiff, closest);
        }

        let pos = sorted.findIndex(n => n >= nums[i]);
        if (pos === -1) {
            sorted.push(nums[i]);
        } else {
            sorted.splice(pos, 0, nums[i]);
        }
    }

    return minDiff;
};