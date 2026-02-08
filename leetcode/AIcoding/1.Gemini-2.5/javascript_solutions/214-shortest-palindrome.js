var shortestPalindrome = function(s) {
    const n = s.length;
    if (n <= 1) {
        return s;
    }

    const reversed_s = s.split('').reverse().join('');
    const temp = s + "#" + reversed_s;
    const m = temp.length;

    const lps = new Array(m).fill(0);
    let length = 0;
    let i = 1;

    while (i < m) {
        if (temp[i] === temp[length]) {
            length++;
            lps[i] = length;
            i++;
        } else {
            if (length !== 0) {
                length = lps[length - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    const longest_pal_prefix_len = lps[m - 1];
    const suffix_to_prepend = s.substring(longest_pal_prefix_len);
    const reversed_suffix = suffix_to_prepend.split('').reverse().join('');

    return reversed_suffix + s;
};