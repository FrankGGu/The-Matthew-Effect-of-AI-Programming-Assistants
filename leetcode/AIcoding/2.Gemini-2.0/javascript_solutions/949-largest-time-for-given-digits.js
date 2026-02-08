var largestTimeFromDigits = function(arr) {
    let ans = "";

    function permute(nums, l, r) {
        if (l == r) {
            let hh = nums[0] * 10 + nums[1];
            let mm = nums[2] * 10 + nums[3];
            if (hh < 24 && mm < 60) {
                let time = String(hh).padStart(2, '0') + ":" + String(mm).padStart(2, '0');
                if (time > ans) {
                    ans = time;
                }
            }
        } else {
            for (let i = l; i <= r; i++) {
                [nums[l], nums[i]] = [nums[i], nums[l]];
                permute(nums, l + 1, r);
                [nums[l], nums[i]] = [nums[i], nums[l]]; // backtrack
            }
        }
    }

    permute(arr, 0, arr.length - 1);
    return ans;
};