var maximumLength = function(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    let ans = 0;
    for (const num of new Set(nums)) {
        let len = 0;
        let curr = num;
        let currCount = count[curr] || 0;

        if (curr === 1) {
            ans = Math.max(ans, count[1] % 2 === 0 ? count[1] - 1 : count[1]);
            continue;
        }

        while (currCount > 0) {
            len += 1;
            if (currCount === 1) {
                break;
            }
            curr = curr * curr;
            currCount = count[curr] || 0;
        }

        ans = Math.max(ans, len * 2 - 1);
    }

    return ans;
};