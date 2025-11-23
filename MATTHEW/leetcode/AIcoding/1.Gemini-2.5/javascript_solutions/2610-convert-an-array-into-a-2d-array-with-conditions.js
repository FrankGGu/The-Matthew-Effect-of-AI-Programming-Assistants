var findMatrix = function(nums) {
    const ans = [];
    const rowSets = [];

    for (const num of nums) {
        let placed = false;
        for (let i = 0; i < rowSets.length; i++) {
            if (!rowSets[i].has(num)) {
                rowSets[i].add(num);
                ans[i].push(num);
                placed = true;
                break;
            }
        }

        if (!placed) {
            ans.push([num]);
            rowSets.push(new Set([num]));
        }
    }

    return ans;
};