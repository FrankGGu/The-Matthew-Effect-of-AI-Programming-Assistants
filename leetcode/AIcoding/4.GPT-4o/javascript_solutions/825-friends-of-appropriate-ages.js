var numFriendRequests = function(ages) {
    let count = 0;
    for (let i = 0; i < ages.length; i++) {
        for (let j = 0; j < ages.length; j++) {
            if (i !== j && isValidRequest(ages[i], ages[j])) {
                count++;
            }
        }
    }
    return count;
};

function isValidRequest(x, y) {
    return !(y <= 0.5 * x + 7 || y > x || (y > 100 && x < 100));
}