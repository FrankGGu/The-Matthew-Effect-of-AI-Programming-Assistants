var numFriendRequests = function(ages) {
    let count = 0;

    for (let i = 0; i < ages.length; i++) {
        for (let j = 0; j < ages.length; j++) {
            if (i !== j && ages[j] > 0.5 * ages[i] + 7 && ages[j] <= ages[i]) {
                count++;
            }
        }
    }

    return count;
};