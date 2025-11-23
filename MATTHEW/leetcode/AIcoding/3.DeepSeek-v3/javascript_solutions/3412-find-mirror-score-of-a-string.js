var findMirrorScore = function(s) {
    const mirror = {'0':'0', '1':'1', '8':'8', '6':'9', '9':'6'};
    let left = 0, right = s.length - 1;
    let score = 0;

    while (left <= right) {
        if (left === right) {
            if (s[left] === '0' || s[left] === '1' || s[left] === '8') {
                score++;
            }
            break;
        }
        const leftChar = s[left];
        const rightChar = s[right];
        if (mirror[leftChar] === rightChar) {
            score += 2;
        }
        left++;
        right--;
    }

    return score;
};