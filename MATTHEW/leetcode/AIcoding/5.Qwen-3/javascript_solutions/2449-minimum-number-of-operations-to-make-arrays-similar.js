function minOperations(nums, target) {
    const count = new Array(32).fill(0);
    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];
        for (let j = 0; j < 32; j++) {
            if (num & (1 << j)) {
                count[j]++;
            }
        }
    }

    let res = 0;
    for (let i = 0; i < target.length; i++) {
        let t = target[i];
        for (let j = 0; j < 32; j++) {
            if (t & (1 << j)) {
                if (count[j] > 0) {
                    count[j]--;
                } else {
                    for (let k = j + 1; k < 32; k++) {
                        if (count[k] > 0) {
                            count[k]--;
                            for (let l = k - 1; l >= j; l--) {
                                count[l]++;
                            }
                            res += (k - j);
                            break;
                        }
                    }
                }
            }
        }
    }

    return res;
}