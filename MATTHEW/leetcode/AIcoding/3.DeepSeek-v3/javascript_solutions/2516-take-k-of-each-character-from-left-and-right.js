var takeCharacters = function(s, k) {
    const count = { a: 0, b: 0, c: 0 };
    const n = s.length;
    for (const char of s) {
        count[char]++;
    }
    if (count.a < k || count.b < k || count.c < k) {
        return -1;
    }

    let left = 0;
    let maxWindow = 0;
    const target = { a: count.a - k, b: count.b - k, c: count.c - k };
    const current = { a: 0, b: 0, c: 0 };

    for (let right = 0; right < n; right++) {
        current[s[right]]++;
        while (current.a > target.a || current.b > target.b || current.c > target.c) {
            current[s[left]]--;
            left++;
        }
        maxWindow = Math.max(maxWindow, right - left + 1);
    }

    return n - maxWindow;
};