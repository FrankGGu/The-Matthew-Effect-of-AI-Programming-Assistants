function minOperations(nums) {
    if (nums.length === 1) return 0;

    const count = {};
    const count2 = {};

    for (let i = 0; i < nums.length; i += 2) {
        count[nums[i]] = (count[nums[i]] || 0) + 1;
    }

    for (let i = 1; i < nums.length; i += 2) {
        count2[nums[i]] = (count2[nums[i]] || 0) + 1;
    }

    let max1 = 0, num1 = -1;
    let max2 = 0, num2 = -1;

    for (const key in count) {
        if (count[key] > max1) {
            max1 = count[key];
            num1 = parseInt(key);
        }
    }

    for (const key in count2) {
        if (count2[key] > max2) {
            max2 = count2[key];
            num2 = parseInt(key);
        }
    }

    if (num1 !== num2) {
        return nums.length - max1 - max2;
    } else {
        let secondMax1 = 0;
        for (const key in count) {
            if (key !== num1 && count[key] > secondMax1) {
                secondMax1 = count[key];
            }
        }

        let secondMax2 = 0;
        for (const key in count2) {
            if (key !== num2 && count2[key] > secondMax2) {
                secondMax2 = count2[key];
            }
        }

        return nums.length - Math.max(max1 + secondMax2, secondMax1 + max2);
    }
}