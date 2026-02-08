var minimumSteps = function(s) {
    let left = 0;
    let right = s.length - 1;
    let steps = 0;
    while (left < right) {
        if (s[left] === '1' && s[right] === '0') {
            steps += right - left;
            left++;
            right--;
        } else if (s[left] === '0') {
            left++;
        } else if (s[right] === '1') {
            right--;
        }
    }
    return steps;
};