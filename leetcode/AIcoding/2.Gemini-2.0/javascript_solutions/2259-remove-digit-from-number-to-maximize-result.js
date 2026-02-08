var removeDigit = function(number, digit) {
    let ans = "";
    for (let i = 0; i < number.length; i++) {
        if (number[i] === digit) {
            let temp = number.substring(0, i) + number.substring(i + 1);
            if (ans === "" || temp > ans) {
                ans = temp;
            }
        }
    }
    return ans;
};