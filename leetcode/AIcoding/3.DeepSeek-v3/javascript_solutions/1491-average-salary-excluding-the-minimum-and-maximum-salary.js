var average = function(salary) {
    let min = Infinity;
    let max = -Infinity;
    let sum = 0;

    for (let s of salary) {
        if (s < min) min = s;
        if (s > max) max = s;
        sum += s;
    }

    return (sum - min - max) / (salary.length - 2);
};