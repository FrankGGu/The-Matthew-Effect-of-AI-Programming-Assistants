var distributeCandies = function(n, limit) {
    let count = 0;

    for (let c1 = 0; c1 <= limit; c1++) {
        for (let c2 = 0; c2 <= limit; c2++) {
            let c3 = n - c1 - c2;
            if (c3 >= 0 && c3 <= limit) {
                count++;
            }
        }
    }

    return count;
};