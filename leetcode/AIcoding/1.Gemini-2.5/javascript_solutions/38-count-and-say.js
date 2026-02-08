var countAndSay = function(n) {
    if (n === 1) {
        return "1";
    }

    let prev = countAndSay(n - 1);
    let result = "";
    let count = 0;
    let char = '';

    for (let i = 0; i < prev.length; i++) {
        if (i === 0) {
            char = prev[i];
            count = 1;
        } else if (prev[i] === char) {
            count++;
        } else {
            result += count + char;
            char = prev[i];
            count = 1;
        }
    }
    result += count + char; // Append the last group

    return result;
};