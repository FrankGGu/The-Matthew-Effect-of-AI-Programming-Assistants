var nextGreaterElement = function(n) {
    let s = String(n).split('');
    let i = s.length - 2;

    while (i >= 0 && s[i] >= s[i + 1]) {
        i--;
    }

    if (i < 0) {
        return -1;
    }

    let j = s.length - 1;
    while (j > i && s[j] <= s[i]) {
        j--;
    }

    [s[i], s[j]] = [s[j], s[i]];

    let left = i + 1;
    let right = s.length - 1;
    while (left < right) {
        [s[left], s[right]] = [s[right], s[left]];
        left++;
        right--;
    }

    let result = parseInt(s.join(''));

    if (result > 2147483647) {
        return -1;
    }

    return result;
};