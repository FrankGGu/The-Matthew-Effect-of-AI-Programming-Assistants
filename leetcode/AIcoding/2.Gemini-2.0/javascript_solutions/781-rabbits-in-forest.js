var numRabbits = function(answers) {
    const count = {};
    let result = 0;

    for (const answer of answers) {
        if (!count[answer]) {
            count[answer] = 0;
        }
        count[answer]++;

        if (count[answer] === 1) {
            result += answer + 1;
        }

        if (count[answer] > answer + 1) {
            count[answer] = 1;
            result += answer + 1;
        }
    }

    return result;
};