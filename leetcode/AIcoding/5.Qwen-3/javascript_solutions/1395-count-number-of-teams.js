function numTeams(rating) {
    let n = rating.length;
    let teams = 0;

    for (let i = 0; i < n; i++) {
        let leftLess = 0, leftGreater = 0;
        let rightLess = 0, rightGreater = 0;

        for (let j = 0; j < i; j++) {
            if (rating[j] < rating[i]) leftLess++;
            else if (rating[j] > rating[i]) leftGreater++;
        }

        for (let j = i + 1; j < n; j++) {
            if (rating[j] < rating[i]) rightLess++;
            else if (rating[j] > rating[i]) rightGreater++;
        }

        teams += leftLess * rightGreater + leftGreater * rightLess;
    }

    return teams;
}