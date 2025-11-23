var fourSum = function(nums, target) {
    const result = [];
    const n = nums.length;

    if (n < 4) {
        return result;
    }

    nums.sort((a, b) => a - b);

    for (let i = 0; i < n - 3; i++) {
        if (i > 0 && nums[i] === nums[i - 1]) {
            continue;
        }

        // Optimization: check if target is too small or too large for current i
        if (nums[i] + nums[i+1] + nums[i+2] + nums[i+3] > target) {
            break;
        }
        if (nums[i] + nums[n-3] + nums[n-2] + nums[n-1] < target) {
            continue;
        }

        for (let j = i + 1; j < n - 2; j++) {
            if (j > i + 1 && nums[j] === nums[j - 1]) {
                continue;
            }

            // Optimization: check if target is too small or too large for current i, j
            if (nums[i] + nums[j] + nums[j+1] + nums[j+2] > target) {
                break;
            }
            if (nums[i] + nums[j] + nums[n-2] + nums[n-1] < target) {
                continue;
            }

            let left = j + 1;
            let right = n - 1;

            while (left < right) {
                const currentSum = nums[i] + nums[j] + nums[left] + nums[right];

                if (currentSum === target) {
                    result.push([nums[i], nums[j], nums[left], nums[right]]);

                    while (left < right && nums[left] === nums[left + 1]) {
                        left++;
                    }
                    while (left < right && nums[right] === nums[right - 1]) {
                        right--;
                    }

                    left++;
                    right--;
                } else if (currentSum < target) {
                    left++;
                } else {
                    right--;
                }
            }
        }
    }

    return result;
};