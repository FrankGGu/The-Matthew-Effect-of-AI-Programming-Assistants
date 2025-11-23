function numberOfOperations(current, correct) {
    let currentMinutes = parseInt(current.split(':')[0]) * 60 + parseInt(current.split(':')[1]);
    let correctMinutes = parseInt(correct.split(':')[0]) * 60 + parseInt(correct.split(':')[1]);
    let diff = correctMinutes - currentMinutes;
    let operations = 0;

    operations += Math.floor(diff / 60);
    diff %= 60;

    operations += Math.floor(diff / 15);
    diff %= 15;

    operations += Math.floor(diff / 5);
    diff %= 5;

    operations += diff;

    return operations;
}