var entryTime = function(security) {
    let ans = 0;
    let prev = -1;
    for (let i = 0; i < security.length; i++) {
        if (security[i] === '1') {
            if (prev !== -1) {
                ans += 1;
            }
            prev = i;
        } else {
            ans += 1;
        }
    }
    return ans;
};