function areNumbersAscending(s) {
    const words = s.split(' ');
    let prevNum = -1;

    for (const word of words) {
        const num = Number(word);
        if (!isNaN(num)) {
            if (num <= prevNum) {
                return false;
            }
            prevNum = num;
        }
    }
    return true;
}