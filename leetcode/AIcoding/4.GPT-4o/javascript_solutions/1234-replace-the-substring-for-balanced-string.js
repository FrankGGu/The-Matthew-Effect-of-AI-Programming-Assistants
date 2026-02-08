function balancedString(s) {
    const required = s.length / 4;
    const count = { 'Q': 0, 'W': 0, 'E': 0, 'R': 0 };

    for (let char of s) {
        count[char]++;
    }

    if (count['Q'] === required && count['W'] === required && count['E'] === required && count['R'] === required) {
        return 0;
    }

    let left = 0, minLength = s.length;

    for (let right = 0; right < s.length; right++) {
        count[s[right]]--;

        while (left < s.length && count['Q'] <= required && count['W'] <= required && count['E'] <= required && count['R'] <= required) {
            minLength = Math.min(minLength, right - left + 1);
            count[s[left]]++;
            left++;
        }
    }

    return minLength;
}