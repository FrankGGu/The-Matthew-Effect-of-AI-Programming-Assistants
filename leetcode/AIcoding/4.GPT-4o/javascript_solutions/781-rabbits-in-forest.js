var numRabbits = function(answers) {
    const count = {};
    for (const answer of answers) {
        count[answer] = (count[answer] || 0) + 1;
    }
    let total = 0;
    for (const answer in count) {
        total += Math.ceil(count[answer] / (parseInt(answer) + 1)) * (parseInt(answer) + 1);
    }
    return total;
};