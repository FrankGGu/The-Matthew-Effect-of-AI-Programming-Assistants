var average = function(salary) {
    let min = Infinity;
    let max = -Infinity;
    let sum = 0;

    for (let i = 0; i < salary.length; i++) {
        if (salary[i] < min) {
            min = salary[i];
        }
        if (salary[i] > max) {
            max = salary[i];
        }
        sum += salary[i];
    }

    sum -= (min + max);
    return sum / (salary.length - 2);
};