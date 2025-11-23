var canChoose = function(groups, nums) {
    let i = 0;
    for (const group of groups) {
        let found = false;
        while (i + group.length <= nums.length) {
            if (nums.slice(i, i + group.length).every((val, idx) => val === group[idx])) {
                i += group.length;
                found = true;
                break;
            } else {
                i++;
            }
        }
        if (!found) return false;
    }
    return true;
};