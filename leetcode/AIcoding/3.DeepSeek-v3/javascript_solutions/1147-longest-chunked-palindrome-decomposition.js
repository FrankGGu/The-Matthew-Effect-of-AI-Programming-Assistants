var longestDecomposition = function(text) {
    let left = 0, right = text.length - 1;
    let leftStr = '', rightStr = '';
    let count = 0;

    while (left <= right) {
        leftStr += text[left];
        rightStr = text[right] + rightStr;

        if (leftStr === rightStr) {
            count += left === right ? 1 : 2;
            leftStr = '';
            rightStr = '';
        }
        left++;
        right--;
    }

    if (leftStr !== '' || rightStr !== '') {
        count += 1;
    }

    return count;
};