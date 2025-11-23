var numTeams = function(ranks) {
    let count = 0;
    const n = ranks.length;

    for (let i = 0; i < n; i++) {
        let leftSmaller = 0, leftLarger = 0, rightSmaller = 0, rightLarger = 0;

        for (let j = 0; j < n; j++) {
            if (ranks[j] < ranks[i]) {
                if (j < i) leftSmaller++;
                else rightSmaller++;
            } else if (ranks[j] > ranks[i]) {
                if (j < i) leftLarger++;
                else rightLarger++;
            }
        }

        count += leftSmaller * rightLarger + leftLarger * rightSmaller;
    }

    return count;
};