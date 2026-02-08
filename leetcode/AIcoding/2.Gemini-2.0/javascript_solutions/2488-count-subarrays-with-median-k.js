var countSubarrays = function(nums, k) {
    let n = nums.length;
    let pos = -1;
    for (let i = 0; i < n; i++) {
        if (nums[i] === k) {
            pos = i;
            break;
        }
    }

    let count = 0;
    let map = new Map();
    map.set(0, 1);
    let balance = 0;

    for (let i = pos - 1; i >= 0; i--) {
        if (nums[i] > k) {
            balance++;
        } else {
            balance--;
        }

        map.set(balance, (map.get(balance) || 0) + 1);
    }

    balance = 0;
    for (let i = pos; i < n; i++) {
        if (nums[i] > k) {
            balance++;
        } else if (nums[i] < k) {
            balance--;
        }

        count += (map.get(-balance) || 0) + (map.get(1 - balance) || 0);
    }

    return count;
};