var recoverArray = function(nums) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let result = [];

    while (n > 1) {
        let diff = nums[1] - nums[0];
        let pos = [];
        let neg = [];
        let seen = new Array(n).fill(false);
        let count = 0;

        for (let i = 0; i < n; i++) {
            if (seen[i]) continue;
            pos.push(nums[i]);
            seen[i] = true;

            let found = false;
            for (let j = i + 1; j < n; j++) {
                if (!seen[j] && nums[j] === nums[i] + diff) {
                    neg.push(nums[j]);
                    seen[j] = true;
                    found = true;
                    break;
                }
            }
        }

        if (pos.length + neg.length !== n) {
            diff = nums[n - 1] - nums[n - 2];
            pos = [];
            neg = [];
            seen = new Array(n).fill(false);

            for (let i = 0; i < n; i++) {
                if (seen[i]) continue;
                pos.push(nums[i]);
                seen[i] = true;

                let found = false;
                for (let j = i + 1; j < n; j++) {
                    if (!seen[j] && nums[j] === nums[i] + diff) {
                        neg.push(nums[j]);
                        seen[j] = true;
                        found = true;
                        break;
                    }
                }
            }
        }

        result.push(diff);

        nums = pos;
        n = nums.length;

        if(nums[0] > neg[0]) {
            result.pop();
            diff = neg[0] - nums[0];
            result.push(diff);
            nums = neg;
            n = nums.length;
        }
        if(diff < 0) {
            result.pop();
            diff = Math.abs(diff);
            result.push(diff);
        }

    }

    return result;
};