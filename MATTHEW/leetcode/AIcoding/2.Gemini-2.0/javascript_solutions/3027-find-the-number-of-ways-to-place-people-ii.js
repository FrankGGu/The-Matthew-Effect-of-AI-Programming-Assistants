var numberOfWays = function(people, points) {
    let n = people.length;
    let m = points.length;
    let count = 0;

    for (let i = 0; i < (1 << n); i++) {
        if (Integer.bitCount(i) !== points.length) continue;

        let selectedPeople = [];
        for (let j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                selectedPeople.push(people[j]);
            }
        }

        let possible = true;
        for (let k = 0; k < m; k++) {
            let pointX = points[k][0];
            let pointY = points[k][1];
            let covered = false;
            for (let l = 0; l < selectedPeople.length; l++) {
                let personX = selectedPeople[l][0];
                let personY = selectedPeople[l][1];
                if (personX >= pointX && personY >= pointY) {
                    covered = true;
                    break;
                }
            }
            if (!covered) {
                possible = false;
                break;
            }
        }

        if (possible) {
            count++;
        }
    }

    return count;
};