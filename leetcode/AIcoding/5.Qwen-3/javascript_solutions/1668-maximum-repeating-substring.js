function maxRepeating(str, pattern) {
    let count = 0;
    let temp = '';
    while (temp.length <= str.length) {
        temp += pattern;
        if (str.includes(temp)) {
            count++;
        } else {
            break;
        }
    }
    return count;
}