var toughestWorkout = function (n, exercises) {
    let result = [];
    let maxDifficulty = 0;

    for (let i = 0; i < n; i++) {
        const difficulty = exercises[i].reduce((a, b) => a + b) / exercises[i].length;
        if (difficulty > maxDifficulty) {
            maxDifficulty = difficulty;
            result = [i + 1];
        } else if (difficulty === maxDifficulty) {
            result.push(i + 1);
        }
    }

    return result;
};