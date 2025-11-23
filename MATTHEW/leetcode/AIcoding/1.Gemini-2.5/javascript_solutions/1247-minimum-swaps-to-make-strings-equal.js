var minimumSwaps = function(s1, s2) {
    let xy_count = 0;
    let yx_count = 0;
    const n = s1.length;

    for (let i = 0; i < n; i++) {
        if (s1[i] !== s2[i]) {
            if (s1[i] === 'x') {
                xy_count++;
            } else {
                yx_count++;
            }
        }
    }

    if ((xy_count + yx_count) % 2 !== 0) {
        return -1;
    }

    let swaps = 0;

    swaps += Math.floor(xy_count / 2);
    swaps += Math.floor(yx_count / 2);

    if (xy_count % 2 === 1) {
        swaps += 2;
    }

    return swaps;
};