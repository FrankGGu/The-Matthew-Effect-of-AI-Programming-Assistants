var findMatrix = function(nums) {
    const freq = new Array(nums.length + 1).fill(0);
    const result = [];

    for (const num of nums) {
        let placed = false;
        for (let i = 0; i < result.length; i++) {
            if (freq[num] <= i) {
                result[i].push(num);
                freq[num]++;
                placed = true;
                break;
            }
        }
        if (!placed) {
            result.push([num]);
            freq[num]++;
        }
    }

    return result;
};