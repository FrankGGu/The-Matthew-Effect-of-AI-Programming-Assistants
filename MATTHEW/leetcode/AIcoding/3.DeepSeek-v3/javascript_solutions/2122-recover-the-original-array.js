var recoverArray = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;

    for (let i = 1; i < n; i++) {
        const diff = nums[i] - nums[0];
        if (diff <= 0 || diff % 2 !== 0) continue;
        const k = diff / 2;
        const res = [];
        const used = new Array(n).fill(false);
        let left = 0, right = i;
        used[0] = true;
        used[i] = true;
        res.push(nums[0] + k);

        for (let j = 1; j < n; j++) {
            if (used[j]) continue;
            while (left < n && (used[left] || nums[left] < nums[j] - 2 * k)) left++;
            while (right < n && (used[right] || nums[right] < nums[j] + 2 * k)) right++;
            if (right >= n || nums[right] !== nums[j] + 2 * k) break;
            used[j] = true;
            used[right] = true;
            res.push(nums[j] + k);
        }

        if (res.length === n / 2) return res;
    }

    return [];
};