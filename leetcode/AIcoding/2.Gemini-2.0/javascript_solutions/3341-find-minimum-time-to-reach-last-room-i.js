var firstCompleteIndex = function(time) {
    let n = time.length;
    let current = 0;
    for (let i = 0; i < n; i++) {
        current += time[i];
    }
    return current;
};