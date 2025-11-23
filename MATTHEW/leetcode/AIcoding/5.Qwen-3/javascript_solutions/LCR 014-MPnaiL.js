function checkInclusion(s1, s2) {
    const len1 = s1.length;
    const len2 = s2.length;

    if (len1 > len2) return false;

    const count = new Array(26).fill(0);

    for (let i = 0; i < len1; i++) {
        count[s1.charCodeAt(i) - 97]++;
    }

    let left = 0;

    for (let right = 0; right < len2; right++) {
        count[s2.charCodeAt(right) - 97]--;

        while (count.some(c => c < 0)) {
            count[s2.charCodeAt(left) - 97]++;
            left++;
        }

        if (right - left + 1 === len1) {
            return true;
        }
    }

    return false;
}