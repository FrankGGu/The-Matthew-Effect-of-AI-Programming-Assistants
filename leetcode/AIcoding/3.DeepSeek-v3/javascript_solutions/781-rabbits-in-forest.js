var numRabbits = function(answers) {
    const count = {};
    for (const num of answers) {
        count[num] = (count[num] || 0) + 1;
    }
    let result = 0;
    for (const [num, c] of Object.entries(count)) {
        const n = parseInt(num);
        const groups = Math.ceil(c / (n + 1));
        result += groups * (n + 1);
    }
    return result;
};