function average(salary) {
    let min = Math.min(...salary);
    let max = Math.max(...salary);
    let sum = salary.reduce((acc, val) => acc + val, 0);
    return (sum - min - max) / (salary.length - 2);
}