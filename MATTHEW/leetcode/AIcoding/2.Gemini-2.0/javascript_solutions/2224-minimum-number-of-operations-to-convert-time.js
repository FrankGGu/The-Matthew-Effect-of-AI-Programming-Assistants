var convertTime = function(current, correct) {
    let currentMinutes = parseInt(current.substring(0, 2)) * 60 + parseInt(current.substring(3, 5));
    let correctMinutes = parseInt(correct.substring(0, 2)) * 60 + parseInt(correct.substring(3, 5));
    let diff = correctMinutes - currentMinutes;
    if (diff < 0) {
        return 0;
    }
    let count = 0;
    count += Math.floor(diff / 60);
    diff %= 60;
    count += Math.floor(diff / 15);
    diff %= 15;
    count += Math.floor(diff / 5);
    diff %= 5;
    count += diff;
    return count;
};