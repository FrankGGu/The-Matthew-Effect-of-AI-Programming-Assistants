var getMinPeople = function(enter, leave) {
    let current = 0;
    let max = 0;
    for (let i = 0; i < enter.length; i++) {
        current += enter[i] - leave[i];
        max = Math.max(max, current);
        if (current < 0) {
            current = 0;
        }
    }
    return max;
};