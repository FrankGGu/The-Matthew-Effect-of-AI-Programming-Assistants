var numTeams = function(rating) {
    let n = rating.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                if ((rating[i] < rating[j] && rating[j] < rating[k]) ||
                    (rating[i] > rating[j] && rating[j] > rating[k])) {
                    count++;
                }
            }
        }
    }

    return count;
};