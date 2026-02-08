var average = function(salary) {
    let minSalary = Math.min(...salary);
    let maxSalary = Math.max(...salary);
    let sum = 0;
    for (let s of salary) {
        sum += s;
    }
    return (sum - minSalary - maxSalary) / (salary.length - 2);
};