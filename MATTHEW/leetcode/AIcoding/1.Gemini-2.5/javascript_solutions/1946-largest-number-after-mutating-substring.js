var largestNumberAfterMutatingSubstring = function(num, change) {
    let numArr = num.split('');
    let inMutation = false;

    for (let i = 0; i < numArr.length; i++) {
        let digit = parseInt(numArr[i]);
        let changedDigit = change[digit];

        if (inMutation) {
            if (changedDigit >= digit) {
                numArr[i] = String(changedDigit);
            } else {
                break; 
            }
        } else {
            if (changedDigit > digit) {
                inMutation = true;
                numArr[i] = String(changedDigit);
            }
        }
    }

    return numArr.join('');
};