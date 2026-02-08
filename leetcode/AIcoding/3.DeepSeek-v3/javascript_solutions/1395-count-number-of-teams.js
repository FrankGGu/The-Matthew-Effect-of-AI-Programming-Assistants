var numTeams = function(rating) {
    let count = 0;
    const n = rating.length;

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